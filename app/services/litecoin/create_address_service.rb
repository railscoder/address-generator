class Litecoin::CreateAddressService
  class << self
    def call(number_of_addresses)
      return unless number_of_addresses.is_a? Integer

      Bitcoin.network = :litecoin

      1.upto(number_of_addresses) do
        key = Bitcoin::generate_key
        address = Bitcoin::pubkey_to_address(key[1])
        LitecoinAddress.create(private_hex: key[0], public_hex: key[1], address: address)
      end
    end
  end
end