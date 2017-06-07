class BitcoinPriceIndex
  include HTTParty
  base_uri 'http://api.coindesk.com'

  # http://api.coindesk.com/v1/bpi/historical/close.json
  def self.get_monthly_historical_range
    # Returns 31 days worth of data
    url = "/v1/bpi/historical/close.json"
    response = get(url)
    return JSON.parse(response)['bpi']
    
    rescue JSON::ParserError => e
      return 'An error was encountered through the Coindesk API. Please try again in a few minutes.'
  end
  
  # http://api.coindesk.com/v1/bpi/historical/close.json?start=2013-09-01&end=2013-09-05
  def self.get_historical_range_between_dates(start_at, end_at)
    url = "/v1/bpi/historical/close.json?start=#{start_at.strftime("%Y-%m-%d")}&end=#{end_at.strftime("%Y-%m-%d")}"
    response = get(url)
    return JSON.parse(response)['bpi']
    
    rescue JSON::ParserError => e
      return 'An error was encountered through the Coindesk API. Please try again in a few minutes.'
  end
end