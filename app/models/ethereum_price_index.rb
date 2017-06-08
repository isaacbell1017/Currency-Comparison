class EthereumPriceIndex
  include HTTParty
  base_uri 'https://etherchain.org'
  # https://etherchain.org/api/statistics/price
  def self.get_price_history
    # Return full historical price logs
    url = '/api/statistics/price'
    response = get(url)
    
    # Convert JSON response containing an array of hashes to a single hash
    return JSON.parse(response.body)['data'].collect(&:values)
    
    rescue JSON::ParserError => e
      return 'An error was encountered through the Etherchain API. Please try again in a few minutes.'
  end
end