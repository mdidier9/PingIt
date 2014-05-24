module FacebookMacros

  def complete_facebook_dialogues_on_click(selector, test_user)
    # until bookface version bumped to latest we have no way to know its ready so delay, not ideal
    sleep 1
    find("#{selector}").click
    return if page.driver.browser.window_handles.length == 1
    within_window('Facebook') do
      fill_in_facebook_form(test_user) if page.has_css?('#loginbutton')
      accept_permissions_outside_facebook
    end
  end

  def fill_in_facebook_form(test_user)
    fill_in('email', :with => "#{test_user.email}")
    fill_in('pass', :with => "#{test_user.password}")
    find('#loginbutton').click
  end

  def accept_additional_permissions
    return if page.driver.browser.window_handles.length == 1
    within_window('Facebook') do
      accept_permissions_outside_facebook
    end
  end

  def accept_permissions_outside_facebook
    find(:xpath, "//button[@name='__CONFIRM__']").click if page.driver.browser.window_handles.length == 2
    find(:xpath, "//button[@name='__CONFIRM__']").click if page.driver.browser.window_handles.length == 2
  end

  def deauth_app
    sleep 1
    page.execute_script %Q{
       FB.api("/me/permissions","DELETE", function(response){
         console.log(response)
       });
     }
    sleep 1
  end

  def logout
    sleep 1
    page.execute_script %Q{
      FB.logout(function(response) {
        // user is now logged out
      });
     }
    sleep 1
  end

end