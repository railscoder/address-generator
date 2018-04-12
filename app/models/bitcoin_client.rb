require 'blockcypher'

class  BitcoinClient

  include Bitcoin::Builder
  Bitcoin.network = :testnet3

  RATE = 10**8
  FEE = 100000

  def initialize
    @block_cypher = BlockCypher::Api.new(network: 'test3', api_token: Settings.api_token)
  end

  def get_balance(address)
  	@block_cypher.address_balance(address)["final_balance"].to_f / RATE
  end

  def send_btc_to(from, to)  
    tx, verify = create_tx(from, to)    
    if verify == "true"
      raw = tx.to_payload.unpack("H*")[0]
      @block_cypher.push_hex(raw)
    else
      puts "Transaction failed"
    end
  end

  #private

    def previuos_attr(address)
      address_info = @block_cypher.address_details(address)

      balance = address_info["balance"]

      if address_info["unconfirmed_txrefs"]

        puts "Have uncofirmed transactions"

      else
        tx_hashes = address_info["txrefs"].map { |txrefs| txrefs["tx_hash"] }

        pr_tx_out_indxs = address_info["txrefs"].map {|output| output["tx_output_n"] }

        pr_txs_hex = tx_hashes.map { |hash| @block_cypher.blockchain_transaction(hash, includeHex: true)["hex"] }

        prev_txs = pr_txs_hex.map { |hex| Bitcoin::P::Tx.new(hex.htb) }

        return [balance, prev_txs, pr_tx_out_indxs]
      end 
    end

    def create_tx(from, to)
      return unless previuos_attr(from.address)

      balance, prev_txs, pr_tx_out_indxs = previuos_attr(from.address)

      key = Bitcoin::Key.new(from.private_hex, from.public_hex)

      amount = balance - FEE

      tx = Bitcoin::Protocol::Tx.new

      prev_txs.each_with_index {|prev_tx, i| tx.add_in Bitcoin::Protocol::TxIn.new(prev_tx.binary_hash, pr_tx_out_indxs[i], i)}
      
      tx.add_out Bitcoin::Protocol::TxOut.value_to_address(amount, to.address)
      
      sigs = prev_txs.each_with_index.map { |prev_tx, i| key.sign(tx.signature_hash_for_input(i, prev_tx))}
      
      sigs.each_with_index { |sig,i| 
        tx.in[i].script_sig = Bitcoin::Script.to_signature_pubkey_script(sig, [key.pub].pack("H*"))
      end
      
      tx = Bitcoin::Protocol::Tx.new( tx.to_payload )

      verify_signatures = prev_txs.each_with_index.map { |prev_tx, i| tx.verify_input_signature(i, prev_tx) }
      
      return tx, verify_signatures.uniq.join
    end

end