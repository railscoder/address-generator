class  BitcoinClient < CryptoClient

  Bitcoin.network = :bitcoin

  def initialize
    super
  end
end