class Bitcoin::SendService
  class << self
    def call(send_to_address)
      client = BitcoinClient.new
      BitcoinAddress.not_withdrawn.find_each do |btc|
        if btc.amount > 0 && client.send_btc_to(btc, send_to_address)
          btc.update(funds_withdrawn: true)
        end
      end
    end
  end
end