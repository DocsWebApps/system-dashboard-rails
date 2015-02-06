require 'test_helper'

class CheckIncidentFunctionsTest < ActionDispatch::IntegrationTest
  
  def setup   
    Capybara.default_driver = :selenium 
    @dash_name=(FactoryGirl.create :company).name
    @sys_name=(System.create name: 'TestSystem', status: 'green', row_id: 1).name
    create_user_for_login_tests
  end
  
  def teardown
    Capybara.default_driver = :rack_test
    Capybara.reset_sessions!
    DatabaseCleaner.clean
  end

  test 'Test all the functions related to managing incidents' do
    # Visit root path
    visit root_path
    check_system_section @sys_name, "No previous incidents recorded", 'green.png'

    # Login with correct credentials
    click_link 'Admin Login'  
    fill_in 'session_email', with: @email
    fill_in 'session_password', with: @password
    click_button 'LOGIN'
    
    # Navigate to Create New Incident page and enter incident details
    click_link 'Create New Incident'
    fill_in 'Fault Reference', with: 'HP12345678'
    fill_in 'Description', with: 'Test Description'
    choose 'P2'
    click_button 'Create Incident'
    text_in_section '.flash-notice', 'Incident successfully saved to the database! Please check the details below.'
    check_system_section @sys_name, "No previous incidents recorded", 'amber.png'
   
    # Navigate to Edit Existing Incident page and update incident
    click_link 'Edit Existing Incident'
    click_link 'Update'
    choose 'P1'
    click_button 'Update Incident'
    text_in_section '.flash-notice', 'Incident successfully updated and saved to the database! Please check the details below.' 
    check_system_section @sys_name, "No previous incidents recorded", 'red.png' 
    
    # Navigate to Edit Existing Incident page and close incident
    click_link 'Edit Existing Incident'
    click_link 'Close'
    text_in_section '.flash-notice', 'Incident HP12345678 has been closed successfully.'
    check_system_section @sys_name, "1 Incident in the last 24 hours", 'green.png'
    
    # Reset incident to 'Open', navigate to Edit Existing incident and delete the incident
    incident=Incident.first
    incident.status='Open'
    incident.save
    incident.system.status='red'
    incident.system.save
     
    click_link 'Edit Existing Incident'
    click_link 'Delete'
    text_in_section '.flash-notice', 'Incident HP12345678 has been deleted successfully.'
    check_system_section @sys_name, "No previous incidents recorded", 'green.png'
    click_link 'Incident Details'
    text_in_section '#incident-section', 'HP12345678', false
    text_in_section '#incident-section', 'Test Description', false
    text_in_section '#history-section', 'HP12345678', false
    text_in_section '#history-section', 'Test Description', false
  end
  
end