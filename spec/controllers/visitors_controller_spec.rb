require 'rails_helper'

RSpec.describe VisitorsController, type: :controller do
  describe "#GET index" do
    let(:btc) { BitcoinPriceIndex.get_historical_range_between_dates(1.year.ago, 1.day.ago) }
    let(:eth) { EthereumPriceIndex.get_price_history }
    let(:nasdaq) { NasdaqGlobalIndex.get_index }
    
    before(:each) do
      stub_request(:any, /api.coindesk.com/).
        to_return(body: File.read(File.join('spec','fixtures', 'fake_coindesk_custom_range.json')))
      stub_request(:any, /etherchain.org/).
        to_return(body: File.read(File.join('spec','fixtures', 'fake_etherchain_api_response.json')))
      stub_request(:any, /quandl.com/).
        to_return(body: File.read(File.join('spec','fixtures', 'fake_quandal_nqgi_data.json')))
      get :index
      assigns
    end
    
    it 'success' do
      expect(response).to be_success
      expect(response).to render_template('index')
    end
    
    it 'assigns @btc' do
      expect(assigns(:btc_data)).to eq btc
    end
    
    it 'assigns @eth' do
      expect(assigns(:eth_data)).to eq eth
    end
    
    it 'assigns @nasdaq_data' do
      expect(assigns(:nasdaq_data)).to eq nasdaq
    end
  end
end