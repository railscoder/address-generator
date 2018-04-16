class Litecoin::GetBalanceService
  class << self
    def call
      client = LitecoinClient.new
      LitecoinAddress.find_each do |ltc|
        ltc.update(amount: client.get_balance(ltc.address))
      end
    end
  end
end