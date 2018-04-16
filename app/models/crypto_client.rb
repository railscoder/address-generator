require 'blockcypher'

class  CryptoClient

  include Bitcoin::Builder

  RATE = 10**8
  FEE = 100000

  def initialize(network = "main", currency = "btc")
    @cypher = BlockCypher::Api.new(network: network, currency: currency, api_token: Settings.api_token)
  end

  def get_balance(address)
  	@cypher.address_balance(address)["final_balance"].to_f / RATE
  end

  def send_btc_to(from, to)  
    tx, verify = create_tx(from, to)    
    return puts "Transaction failed" unless verify
    raw = tx.to_payload.unpack("H*")[0]
    @cypher.push_hex(raw)
  end

  def previuos_attr(address)
    address_info = @cypher.address_details(address)

    return puts "Have unconfirmed transaction" if address_info["unconfirmed_txrefs"]

    amount = address_info["balance"] - FEE

    tx_hashes = address_info["txrefs"].map { |txrefs| txrefs["tx_hash"] }

    pr_tx_out_indxs = address_info["txrefs"].map {|out| out["tx_output_n"] }

    pr_txs_hex = tx_hashes.map { |hash| @cypher.blockchain_transaction(hash, includeHex: true)["hex"] }
    
    prev_txs = pr_txs_hex.map { |hex| Bitcoin::P::Tx.new(hex.htb) }

    return [amount, prev_txs, pr_tx_out_indxs]
  end



  def create_tx(from, to)
    return unless previuos_attr(from.address)

    amount, prev_txs, pr_tx_out_indxs = previuos_attr(from.address)

    key = Bitcoin::Key.new(from.private_hex, from.public_hex)

    tx = Bitcoin::Protocol::Tx.new

    prev_txs.each_with_index do |prev_tx, i|
      tx.add_in Bitcoin::Protocol::TxIn.new(prev_tx.binary_hash, pr_tx_out_indxs[i], i)
    end
      
    tx.add_out Bitcoin::Protocol::TxOut.value_to_address(amount, to.address)
      
    sigs = prev_txs.each_with_index.map { |prev_tx, i| key.sign(tx.signature_hash_for_input(i, prev_tx))}
      
    sigs.each_with_index do |sig,i| 
      tx.in[i].script_sig = Bitcoin::Script.to_signature_pubkey_script(sig, [key.pub].pack("H*"))
    end
      
    tx = Bitcoin::Protocol::Tx.new( tx.to_payload )

    verify_signatures = prev_txs.each_with_index.map { |prev_tx, i| tx.verify_input_signature(i, prev_tx) }
    
    verify = verify_signatures.uniq.join == "true"

    return tx, verify
  end

end