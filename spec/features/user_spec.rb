require 'spec_helper'

feature 'User browsing the website' do

  scenario "on homepage" do
    visit root_path
    expect(page).to have_content("Login with Facebook")
  end

  scenario "can login with facebook" do
    visit root_path
    page.should have_content("Login with Facebook")
    mock_auth_hash
    click_link "Login with Facebook"
    page.should have_content("Create Ping")
  end

  # scenario "can create a ping" do
  #   visit root_path
  #   page.should have_content("Login with Facebook")
  #   mock_auth_hash
  #   click_link("Login with Facebook")
  #   click_link("Create Ping!")
  #   page.should have_content("sdf")
  # end
end
