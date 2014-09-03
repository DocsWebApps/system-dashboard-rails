require 'test_helper' 

class ViewIncidentDetailsTest < ActionDispatch::IntegrationTest
  
  def setup
    Capybara.default_driver = :selenium
    FactoryGirl.create :company
    system=FactoryGirl.create :system_with_incidents
    @sys_name=system.name
    @incident_detail_desc=system.incidents.first.description
    @incident_hist_desc=system.incident_histories.first.description
    system.set_system_status
    visit root_path
    click_link 'Incident Details'
  end
  
  def teardown
    Capybara.default_driver = :rack_test
    DatabaseCleaner.clean
  end
  
  test 'Check the contents of the page' do
    # Check content of the <div> .nav
    css_in_page '.nav' 
    text_in_section '.brand', "#{@dash_name} System Dashboard"
    text_in_section '.nav', 'View Dashboard'
    text_in_section '.nav', 'Contacts'
    text_in_section '.nav', 'Tell Us?'
    text_in_section '.nav', 'Admin Login'
    
    # Check the contents of the <div> .title-section
    css_in_page '.title-section' 
    text_in_section('.title-section', 'System Incident Information')  
    text_in_section('.title-section', "Information about incidents that have occurred on #{@sys_name}")

    # Check the contents of the <div> .main-section
    text_in_section('.main-section', @sys_name)
    image_in_section('.main-section', 'amber.png', 1)
    text_in_section('.main-section', 'Show Incident History')
    text_in_section('.main-section', "Recent Incidents")
    css_in_page '#incident-details' 
    text_in_section '#incident-details', @incident_detail_desc
    check 'history-check-box'
    text_in_section('.main-section', "Historic Incidents")
    text_in_section '#incident-details', @incident_hist_desc 
  end
   
end