class Ethereum::SendTokenService
  class << self
    def call
      client = EthereumClient.new(Settings.path)
      contract = client.set_contract(Settings.name, Settings.address, Settings.abi)
      contract.sender = Settings.sender
      884.times do 
        EthereumAddress.where(tx_id: nil).limit(30).each do |eth|
          response = contract.transact.transfer(eth.address, eth.token_amount.to_i)
          eth.update(tx_id: response.id)
        end
        sleep(60)
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
            r = rand(0..8)
            decimal = rand(0..10**r)*(10**(18-r))
            decimal_ta = rand(ta/10..ta*2) * (10**18) + decimal
            token_array.push(decimal_ta.to_s)
          end
        end
        return token_array.shuffle
      end
    end
end