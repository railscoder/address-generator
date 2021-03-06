class EthereumClient < Ethereum::IpcClient

  WEI_IN_ETHER = 10**18

  DEFAULT_GAS_LIMIT = 100_000

  DEFAULT_GAS_PRICE = 2_000_000_000

  def initialize(path)
    super(path)
    @gas_price = DEFAULT_GAS_PRICE
    @gas_limit = DEFAULT_GAS_LIMIT
  end

  def get_balance(address)
  	super(address).to_f / WEI_IN_ETHER
  end

  def send_eth_to(from, to, amount_eth)
  	begin
  	  key =Eth::Key.new(priv: from.private_hex)
  	  amount = (amount_eth * WEI_IN_ETHER).to_i
  	  transfer(key, to, amount)
  	rescue
  	  puts "Transaction failed"
  	end
  end

  def set_contract(name, address, abi)
    Ethereum::Contract.create(name: name, address: address, abi: abi, client: self)
  end
end