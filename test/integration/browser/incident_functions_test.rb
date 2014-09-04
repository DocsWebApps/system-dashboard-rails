require 'test_helper'

class IncidentFunctionsTest < ActionDispatch::IntegrationTest
  
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
    check_system_section @sys_name, "No previous incidents recorded yet", 'green.png'

    # Check content of the <div> .nav
    css_in_page '.nav' 
    text_in_section '.brand', "#{@dash_name} System Dashboard"
    text_in_section '.nav', 'View Dashboard'
    text_in_section '.nav', 'Contacts'
    text_in_section '.nav', 'Tell Us?'
    text_in_section '.nav', 'Admin Login'
    text_in_section '.nav', 'Create New Incident', false
    text_in_section '.nav', 'Edit Existing Incident', false

    # Login with correct credentials
    click_link 'Admin Login'  
    fill_in 'session_email', with: @email
    fill_in 'session_password', with: @password
    click_button 'LOGIN'
    
    # Check content of the <div> .nav
    css_in_page '.nav' 
    text_in_section '.brand', "#{@dash_name} System Dashboard"
    text_in_section '.nav', 'View Dashboard'
    text_in_section '.nav', 'Contacts'
    text_in_section '.nav', 'Tell Us?'
    text_in_section '.nav', 'Admin Login', false
    text_in_section '.nav', 'Create New Incident'
    text_in_section '.nav', 'Edit Existing Incident'
    
    # Navigate to Create New Incident page and enter incident details
    click_link 'Create New Incident'
    fill_in 'HP Reference', with: 'HP12345678'
    fill_in 'Description', with: 'Test Description'
    choose 'P2'
    click_button 'Create Incident'
    text_in_section '.flash-notice', 'Incident successfully saved to the database! Please check the details below.'
    visit root_path
    check_system_section @sys_name, "No previous incidents recorded yet", 'amber.png'
   
    # Navigate to Edit Existing Incident page and update incident
    click_link 'Edit Existing Incident'
    click_link 'Update'
    choose 'P1'
    click_button 'Update Incident'
    text_in_section '.flash-notice', 'Incident successfully updated and saved to the database! Please check the details below.' 
    visit root_path
    check_system_section @sys_name, "No previous incidents recorded yet", 'red.png' 
    
    # Navigate to Edit Existing Incident page and close incident
    click_link 'Edit Existing Incident'
    click_link 'Close'
    text_in_section '.flash-notice', 'Incident HP12345678 has been closed successfully.'
    visit root_path
    check_system_section @sys_name, "1 Incident in the last 24 hours", 'green.png'
    
    # Reset incident to 'Open', navigate to Edit Existing incident and downgrade incident
    incident=Incident.first
    incident.status='Open'
    incident.save
     
    click_link 'Edit Existing Incident'
    click_link 'Downgrade'
    text_in_section '.flash-notice', 'Incident HP12345678 has been downgraded successfully.'
    visit root_path
    check_system_section @sys_name, "No previous incidents recorded yet", 'green.png'
    click_link 'Incident Details'
    text_in_section '#incident-details', 'HP12345678', false
    text_in_section '#incident-details', 'Test Description', false
    check 'history-check-box'
    text_in_section '#incident-history', 'HP12345678'
    text_in_section '#incident-history', 'Test Description'

    # Make the downgraded incident older and it should not trigger an indicator change
    incident=IncidentHistory.first
    incident.date=Time.now-24.hours
    incident.save
    visit root_path
    check_system_section @sys_name, "No previous incidents recorded yet", 'green.png'
  end
  
end