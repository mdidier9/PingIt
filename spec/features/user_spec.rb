require 'spec_helper'
# include OauthFaker

feature 'User browsing the website' do
    # let (:test_user_mark) {FactoryGirl.build(:test_user_mark)}
  scenario "on homepage" do
    visit root_path
    expect(page).to have_content "Login with Facebook"
  end

  # scenario "logs in in with facebook" do
  #   visit root_path
  #   click_link "Login with Facebook"
  #   expect(page).to have_content("test")
  # end

    # it "logs in a test user" do
    #   # FactoryGirl.build(:test_user_mark)
    #   # expect(page).to have_content("test")
    # end
end
