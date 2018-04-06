class AddressService
  class << self
  	def call(number_of_addresses)
      return unless number_of_addresses.is_a? Integer

      create(number_of_addresses)
      puts "+" * 20
      puts "created #{number_of_addresses} #{service_name} addresses"
    end

    def service_name
      name.split("::")[0].downcase
    end

    def path_to_file
      "addresses/#{service_name}/#{service_name}-address-#{time}.txt"
    end
    
    private
      def time
        DateTime.now.strftime("%Y-%m-%d-%H-%M")
      end
  end
end