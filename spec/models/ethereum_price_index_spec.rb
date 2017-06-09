require 'rails_helper'

RSpec.describe EthereumPriceIndex, type: :model do
  describe "#get_monthly_historical_range" do
    it "should make http request to Coindesk API service" do
      stub_request(:any, /etherchain.org/).
        to_return(body: File.read(File.join('spec','fixtures', 'fake_etherchain_api_response.json')))
      
      expect(EthereumPriceIndex.get_price_history).to be_a(Array)
      expect(EthereumPriceIndex.get_price_history.first[0]).to be_a(String)
      expect(EthereumPriceIndex.get_price_history.first[1]).to be_a(Float)
    end
  end
end