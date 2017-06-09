require 'spec_helper'

feature "User checks Bitcoin index" do
  # Note: The test boundary for this demo is the data that is passed 
  # to Highchart; there's no point in testing Highchart's rendering/graphing
  scenario "Visitor checks Bitcoin value over the last month" do
    # As a visitor
    # I want to see the historical values of Bitcoin, Ethereum, and the NASDAQ charted out
    # So that I can compare and make more informed financial decisions
    
    visit root_path
    expect(page).to have_content("Currency Comparison Tool")
    expect(page).to have_content('Compare Bitcoin, Ethereum, and NASDAQ historical values')
  end
end