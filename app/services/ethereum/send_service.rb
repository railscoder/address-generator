class Ethereum::SendService
  class << self
    def call(send_to_address)
      client = EthereumClient.new
      EthereumAddress.not_withdrawn.find_each do |eth|
        amount = (client.get_balance(eth.address) - 0.00084).round(5)
        if amount > 0 && client.send_eth_to(eth, send_to_address, amount)
          eth.update(funds_withdrawn: true)
        end
      end
    end
  end
end