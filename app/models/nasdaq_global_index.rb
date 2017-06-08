class NasdaqGlobalIndex
  include HTTParty
  base_uri 'https://www.quandl.com'
  
  # https://www.quandl.com/api/v3/datasets/NASDAQOMX/NQGI.json?api_key=#{Quandl_API_KEY}
  def self.get_index
    url = "/api/v3/datasets/NASDAQOMX/NQGI.json?api_key=#{ENV['Quandl_API_KEY']}"
    response = get(url)
    
    # Convert JSON response containing an array of hashes to a single hash
    return JSON.parse(response.body)['dataset']['data'].map{|index|index.slice(0,2)}
  end
end
