require 'rails_helper'

RSpec.describe EthereumPriceIndex, type: :model do
  describe "#get_monthly_historical_range" do
    it "should make http request to Coindesk API service" do
      stub_request(:any, /etherchain.org/).
        to_return(body: File.read(File.join('spec','fixtures', 'fake_etherchain_api_response.json')))
      
      expect(EthereumPriceIndex.get_price_history).to be_a(Hash)
      expect(EthereumPriceIndex.get_price_history.first[0]).to eq('time')
    end
  end
  
  context "when Etherchain API can't be reached" do
    before(:each) do
      # TODO: Stub out error response
      # stub_request(:any, /etherchain.org/).
        # to_return(body: File.read(File.join('spec','fixtures', 'fake_etherchain_error.html')))
    end
    describe "#get_monthly_historical_range" do
      it "should return an error message " do
          
        skip 'Need failure example'
      end
    end
  end
end