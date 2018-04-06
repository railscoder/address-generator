class Ethereum::CreateAddressService
  class << self
    def call(number_of_addresses)
      return unless number_of_addresses.is_a? Integer

      1.upto(number_of_addresses) do
        key = Eth::Key.new
        EtherumAddress.create(private_hex: key.private_hex, public_hex: key.public_hex, address: key.address)
      end
    end
  end
end