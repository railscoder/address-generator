class Ethereum::SendTokenService
  class << self
    def call
      client = EthereumClient.new(Settings.path)
      contract = client.set_contract(Settings.name, Settings.address, Settings.abi)
      contract.sender = Settings.sender
      60.times do 
        EthereumAddress.where(tx_id: nil).limit(200).each do |eth|
          response = contract.transact.transfer(eth.address, eth.token_amount.to_i)
          eth.update(tx_id: response.id)
        end
        sleep(120)
      end
    end

    def prepare_holders
      array_token_amount = token_distribution
      array_token_amount.each_with_index do |val, index|
        EthereumAddress.find(index + 1).update(token_amount: val)
      end
    end

    #private

      def token_distribution
        token_array = []
        Settings.distribution.each do |distrib|
          total = distrib[0]
          amount = distrib[1]
          ta = total/amount
          amount.times do
            ta = total/amount
            token_array.push(rand(ta/10..ta*2))
          end
        end
        return token_array.shuffle
      end
    end
end