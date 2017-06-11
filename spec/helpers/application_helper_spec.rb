RSpec.describe ApplicationHelper, :type => :helper do
  let(:btc_data) { BitcoinPriceIndex.get_historical_range_between_dates(1.year.ago, 1.day.ago) }
  let(:eth_data) { EthereumPriceIndex.get_price_history }
  let(:nasdaq) { NasdaqGlobalIndex.get_index }
  
  before(:each) do
    stub_request(:any, /api.coindesk.com/).
      to_return(body: File.read(File.join('spec','fixtures', 'fake_coindesk_custom_range.json')))
    stub_request(:any, /etherchain.org/).
      to_return(body: File.read(File.join('spec','fixtures', 'fake_etherchain_api_response.json')))
    stub_request(:any, /quandl.com/).
      to_return(body: File.read(File.join('spec','fixtures', 'fake_quandal_nqgi_data.json')))
  end
  
  describe "#bitcoin_data_by_date" do
    it "should format Bitcoin data to be evaluatable by JS" do
      expect(helper.bitcoin_data_by_date(btc_data)).to be_a(String)
      expect(helper.bitcoin_data_by_date(btc_data)).to start_with('[[Date.UTC')
      expect(helper.bitcoin_data_by_date(btc_data)).to end_with(']]')
    end
  end
  
  describe "#ethereum_data_by_date" do
    it "should format Ethereum data properly to be evaluatable by JS" do
      expect(helper.ethereum_data(eth_data)).to be_a(String)
      expect(helper.ethereum_data(eth_data)).to start_with('[[Date.UTC')
      expect(helper.ethereum_data(eth_data)).to end_with(']]')
    end
  end
  
  describe "#nasdq_data_by_date" do
    it "should format NASDAQ data to be evaluatable by JS" do
      expect(helper.nasdaq_data(nasdaq)).to be_a(String)
      expect(helper.nasdaq_data(nasdaq)).to start_with('[[Date.UTC')
      expect(helper.nasdaq_data(nasdaq)).to end_with(']]')
    end
  end
  
end