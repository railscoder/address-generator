class AddressService
  class << self
    private
      def time
        DateTime.now.strftime("%Y-%m-%d-%H-%M")
      end
  end
end