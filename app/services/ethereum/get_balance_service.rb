class Ethereum::GetBalanceService
  class << self
    def call
      client = EthereumClient.new
      EthereumAddress.find_each do |eth|
        eth.update(amount: client.get_balance(eth.address))
      end
    end
  end
end