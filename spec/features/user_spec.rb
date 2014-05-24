require 'spec_helper'
# include OauthFaker

feature 'User browsing the website' do
  context "on homepage" do
    # let (:test_user_mark) {FactoryGirl.build(:test_user_mark)}

    it "sees a list of recent posts titles" do
      visit root_path
      expect(page).to have_content "Login with Facebook"
    end

    # it "login in with facebook" do
    #   visit root_path
    #   click_link "Login with Facebook"
    #   expect(page).to have_content("test")
    # end

    # it "logs in a test user" do
    #   # FactoryGirl.build(:test_user_mark)
    #   # expect(page).to have_content("test")
    # end
  end

end
