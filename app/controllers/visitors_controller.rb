class VisitorsController < ApplicationController
  # GET "/"
  def index
    @btc_data    = BitcoinPriceIndex.get_historical_range_between_dates(1.year.ago, 1.day.ago)
    @eth_data    = EthereumPriceIndex.get_price_history
    @nasdaq_data = NasdaqGlobalIndex.get_index
  end
end
