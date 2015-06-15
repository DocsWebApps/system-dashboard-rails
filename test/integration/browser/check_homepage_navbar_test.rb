require 'test_helper'

class CheckHomepageNavbarTest < ActionDispatch::IntegrationTest
  
  def setup
    Capybara.default_driver = :selenium
    @dash_name=(FactoryGirl.create :company).name
    contact=FactoryGirl.create :contact
    create_user_for_login_tests
    visit root_path
  end
  
  def teardown
    Capybara.default_driver = :rack_test
    Capybara.reset_sessions!
    DatabaseCleaner.clean
  end

  test 'Check the contents of the navbar'  do
    # Check content of the <div> .nav
    is_css_in_page? '.nav' 
    is_text_in_section? '.navbar-brand', "System Dashboard"
    is_text_in_section? '.navbar-nav', 'Dashboard'
    is_text_in_section? '.navbar-nav', 'Contacts'
    is_text_in_section? '.navbar-nav', 'Admin Login'
    is_text_in_section? '.navbar-nav', 'Create Incident', false
    is_text_in_section? '.navbar-nav', 'Edit Incident', false

    # Login with correct credentials
    click_link 'Admin Login'  
    fill_in 'session_email', with: @email
    fill_in 'session_password', with: @password
    click_button 'LOGIN'

    # Check content of the <div> .nav
    is_css_in_page?  '.nav' 
    is_text_in_section? '.navbar-brand', "System Dashboard"
    is_text_in_section? '.navbar-nav', 'Dashboard'
    is_text_in_section? '.navbar-nav', 'Contacts'
    is_text_in_section? '.navbar-nav', 'Admin Login', false
    is_text_in_section? '.navbar-nav', 'Create Incident'
    is_text_in_section? '.navbar-nav', 'Edit Incident'
  end
  
end