class Bitcoin::GetBalanceService
  class << self
    def call
      client = BitcoinClient.new
      BitcoinAddress.find_each do |btc|
        btc.update(amount: client.get_balance(btc.address))
      end
    end
  end
end