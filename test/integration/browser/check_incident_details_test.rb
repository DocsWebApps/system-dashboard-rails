require 'test_helper' 

class CheckIncidentDetailsTest < ActionDispatch::IntegrationTest
  
  def setup
    Capybara.default_driver = :selenium
    FactoryGirl.create :company
    system=FactoryGirl.create :system_with_incidents
    @sys_name=system.name
    @incident_detail_desc=system.incidents.first.description
    @incident_hist_desc=system.incident_histories.first.description
    system.update_status
    visit root_path
    click_link 'Incident Details'
  end
  
  def teardown
    Capybara.default_driver = :rack_test
    DatabaseCleaner.clean
  end

  test 'Check the title of #details-modal'  do 
    # Check the contents of the <div> .title-section
    css_in_page '#details-modal' 
    text_in_section('#details-modal', "Current Status of  #{@sys_name}")
    image_in_section('#details-modal', 'amber.png', 1)
  end

  test 'Check the contents of #details-modal'  do 
    # Check the contents of the <div> .main-section
    text_in_section('#incident-section', "Incidents Occuring in the last 24 hours")
    text_in_section '#incident-section', @incident_detail_desc
    text_in_section('#history-section', "Chronological List of Historic Incidents")
    text_in_section '#history-section', @incident_hist_desc 
  end
   
end