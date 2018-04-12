class  LitecoinClient < CryptoClient

  Bitcoin.network = :litecoin

  def initialize
    super('main', 'ltc')
  end
end