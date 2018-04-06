class Ethereum::CreateAddressService < AddressService
  class << self
    def create(number_of_addresses)
      file_with_adddresses = File.open(path_to_file, "w")

      ActiveRecord::Base.transaction do
        1.upto(number_of_addresses) do
          key = Eth::Key.new
          EthereumAddress.create(private_hex: key.private_hex, public_hex: key.public_hex, address: key.address)
          file_with_adddresses.puts key.address
        end

        file_with_adddresses.close
      end
    end
  end
end