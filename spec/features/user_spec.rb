require 'spec_helper'

feature 'User browsing the website' do

  scenario "on homepage" do
    visit root_path
    expect(page).to have_content("When and Where")
  end

  scenario "can login with facebook" do
    visit root_path
    mock_auth_hash
    click_link "sign_in"
    page.should have_content("Ping Create")
  end
end
