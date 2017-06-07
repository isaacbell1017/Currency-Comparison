require 'spec_helper'

feature "User checks Bitcoin index" do
  scenario "Visitor checks Bitcoin value over the last month" do
    visit "/"
    # Expect Highcharts to display
    expect(page).to have_content(31.days.ago.strftime("%Y-%m-%d"))
    expect(page).to have_content('Or, input a custom date range')
  end
  
  scenario "Visitor inputs custom date range" do
    visit "/"
    fill_in 'Start Date', with: 7.days.ago
    fill_in 'End Date', with: 1.day.ago
    click_button 'Search by date range'
  end
end