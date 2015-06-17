require 'test_helper'

class CheckAutoupdateTest < ActionDispatch::IntegrationTest
  
  def setup   
    Capybara.default_driver = :selenium 
    (FactoryGirl.create :company).name
    @system=System.create name: 'TestSystem', status: 'green', row_id: 1
    create_user_for_login_tests
  end
  
  def teardown
    Capybara.default_driver = :rack_test
    Capybara.reset_sessions!
    DatabaseCleaner.clean
  end

  test 'Check Homepage autoupdates upon a status change' do
    # Visit root path
    visit root_path
    check_system_section @system.name, "No previous incidents recorded", 'green.png'

    # Login with correct credentials
    click_link 'Admin Login'  
    fill_in 'session_email', with: @email
    fill_in 'session_password', with: @password
    click_button 'LOGIN'
    
    # Navigate to Create New Incident page and enter incident details
    click_link 'Create Incident'
    fill_in 'Fault Reference', with: 'HP12345678'
    fill_in 'Description', with: 'Test Description'
    choose 'P2'
    click_button 'Create Incident'
    is_text_in_section? '.flash-notice', 'Incident successfully saved to the database! Please check the details below.'
    check_system_section @system.name, "No previous incidents recorded", 'amber.png'

    # Update the incident in the background to simulate another user updating the incident
    incident=@system.incidents.first
    incident.severity='P1'
    incident.save
    @system.update_status

    # Wait 30secs and then check the Homepage, it should now be a P1 (red.png) ie. autoupdated !!
    sleep(30) # Must change to 30 when feature is ready !!!!!!!!!!!!!!!!!
    check_system_section @system.name, "No previous incidents recorded", 'red.png'
  end
  
end