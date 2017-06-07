require 'rails_helper'
require 'httparty'

RSpec.describe BitcoinPriceIndex, type: :model do
  let (:btcpi) { BitcoinPriceIndex.new }
  
  describe "#get_monthly_historical_range" do
    it "should make http request to Coindesk API service" do
      stub_request(:any, /api.coindesk.com/).
        to_return(body: File.read(File.join('spec','fixtures', 'fake_coindesk_monthly_range.json')))
      
      expect(BitcoinPriceIndex.get_monthly_historical_range).to be_a(Hash)
      expect(BitcoinPriceIndex.get_monthly_historical_range.first[0]).to be_a(String)
      expect(BitcoinPriceIndex.get_monthly_historical_range.first[1]).to be_a(Float)
    end
  end
  
  describe "#get_historical_range_between_dates" do
    it "should make http request to Coindesk API service" do
      stub_request(:any, /api.coindesk.com/).
        to_return(body: File.read(File.join('spec','fixtures', 'fake_coindesk_custom_range.json')))
      
      expect(BitcoinPriceIndex.get_historical_range_between_dates(3.days.ago, 1.day.ago) ).to be_a(Hash)
      expect(BitcoinPriceIndex.get_monthly_historical_range.first[0]).to be_a(String)
      expect(BitcoinPriceIndex.get_monthly_historical_range.first[1]).to be_a(Float)
    end
  end
  
  context "when Coindesk API can't be reached" do
    before(:each) do
      stub_request(:any, /api.coindesk.com/).
        to_return(body: File.read(File.join('spec','fixtures', 'fake_coindesk_error_response.html')))
    end
    describe "#get_monthly_historical_range" do
      it "should return an error message " do
          
        expect(BitcoinPriceIndex.get_monthly_historical_range).
          to eq('An error was encountered through the Coindesk API. Please try again in a few minutes.')
      end
    end
    describe "#get_historical_range_between_dates" do
      it "should make http request to Coindesk API service" do
        expect(BitcoinPriceIndex.get_historical_range_between_dates(3.days.ago, 1.day.ago) ).
          to eq('An error was encountered through the Coindesk API. Please try again in a few minutes.')
      end
    end
  end
end