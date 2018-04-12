class Bitcoin::CreateAddressService < AddressService
  class << self
    def create(number_of_addresses)
      Bitcoin.network = :bitcoin

      file_with_adddresses = File.open(path_to_file, "w")

      ActiveRecord::Base.transaction do
        number_of_addresses.times do
          key = Bitcoin::generate_key
          address = Bitcoin::pubkey_to_address(key[1])
          BitcoinAddress.create(private_hex: key[0], public_hex: key[1], address: address)
          file_with_adddresses.puts address
        end

        file_with_adddresses.close
      end
    end
  end
end