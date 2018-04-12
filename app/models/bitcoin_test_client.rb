class  BitcoinTestClient < CryptoClient

  Bitcoin.network = :testnet3

  def initialize
    super('test3')
  end
end