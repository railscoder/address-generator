require "ethereum.rb"

class Contract < Ethereum::Contract

  def initialize(name, abi, address)
    super(name, abi, address)
  end
end