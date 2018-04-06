class Litecoin::CreateAddressService < AddressService
  class << self
    def call(number_of_addresses)
      return unless number_of_addresses.is_a? Integer

      Bitcoin.network = :litecoin

      file_with_adddresses = File.open("addresses/ltc/ltc-address-#{time}.txt", "w")
      
      ActiveRecord::Base.transaction do
        1.upto(number_of_addresses) do
          key = Bitcoin::generate_key
          address = Bitcoin::pubkey_to_address(key[1])
          LitecoinAddress.create(private_hex: key[0], public_hex: key[1], address: address)
          file_with_adddresses.puts address
        end

        file_with_adddresses.close
      end
      
      puts "+++++++++++++++++++++++++++++++++++++++++++++++++"

      puts "created #{number_of_addresses} litecoin addresses"
    end
  end
end