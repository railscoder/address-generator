class Ethereum::CreateAddressService < AddressService
  class << self
    def call(number_of_addresses)
      return unless number_of_addresses.is_a? Integer

      file_with_adddresses = File.open("addresses/eth/eth-address-#{time}.txt", "w")

      ActiveRecord::Base.transaction do
        1.upto(number_of_addresses) do
          key = Eth::Key.new
          EthereumAddress.create(private_hex: key.private_hex, public_hex: key.public_hex, address: key.address)
          file_with_adddresses.puts key.address
        end

        file_with_adddresses.close
      end

      puts "created #{number_of_addresses} ethereum addresses"
    end
  end
end