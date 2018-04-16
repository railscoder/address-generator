class Litecoin::SendService
  class << self
    def call(send_to_address)
      client = LitecoinClient.new
      LitecoinAddress.not_withdrawn.find_each do |ltc|
        if ltc.amount > 0 && client.send_btc_to(ltc, send_to_address)
          ltc.update(funds_withdrawn: true)
        end
      end
    end
  end
end