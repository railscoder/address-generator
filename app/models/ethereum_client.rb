class EthereumClient < Ethereum::HttpClient

  WEI_IN_ETHER = 10**18
  GAS_PRICE = 40_000_000_000
  GAS_LIMIT = 21_000

  def initialize
    super(Settings.test_ethereum_node)
    @gas_price = GAS_PRICE
    @gas_limit = GAS_LIMIT
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
end