class VisitorsController < ApplicationController
  # GET "/"
  def index
    @btc_data = BitcoinPriceIndex.get_historical_range_between_dates(1.year.ago, 1.day.ago).to_json
    @eth_data = EthereumPriceIndex.get_price_history.to_json
    @nasdaq   = NasdaqGlobalIndex.get_index.to_json
  end
end
