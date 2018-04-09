class Ethereum::Client

  WEI_IN_ETHER = 10**18

  def initialize
    @client = Ethereum::HttpClient.new("http://#{ethereum_node}")
  end
end