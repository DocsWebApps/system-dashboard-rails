require 'test_helper'

# Tests the layout of the page by setting up a set of incidents and intregating the html/css that gets returned

class DashboardFunctionsTest < ActionDispatch::IntegrationTest
  
  def setup 
    @contact=FactoryGirl.create :contact 
    @dash_name=(FactoryGirl.create :company).name
    @system=Hash.new
    @system['kirk']=FactoryGirl.create :system, name: 'kirk'
    @system['kirk'].incident_histories.create severity: 'D', description: 'Test data', date: Date.today, time: Time.now, hp_ref: 'HP4444444', status: 'Closed'
    @system['spock']=FactoryGirl.create :system, name: 'spock'
    @system['spock'].incidents.create severity: 'P2', description: 'Test data', date: Date.today, time: Time.now, hp_ref: 'HP5555555', status: 'Open' 
    @system['bones']=FactoryGirl.create :system, name: 'bones'
    @system['bones'].incidents.create severity: 'P1', description: 'Test data', date: Date.today, time: Time.now, hp_ref: 'HP11111111', status: 'Closed', closed_at: Time.now 
    @system['sulu']=FactoryGirl.create :system, name: 'sulu', last_incident_date: Date.today-3
    @system['sulu'].incidents.create severity: 'P1', description: 'Test data', date: Date.today, time: Time.now, hp_ref: 'HP22222222', status: 'Open'  
    @system['sulu'].incident_histories.create severity: 'P1', description: 'Test data', date: Date.today-4, time: Time.now, hp_ref: 'HP3333333', status: 'Closed', closed_at: Time.now-72.hours
    @system.each { |key, value | value.update_status }
    visit root_path 
    click_link('View Dashboard')
  end
        
  def teardown
    DatabaseCleaner.clean
  end
  
  test 'Check the contents of the page'  do
    # Check content of the <div> .nav
    css_in_page '.nav' 
    text_in_section '.brand', "#{@dash_name} System Dashboard"
    text_in_section '.nav', 'View Dashboard'
    text_in_section '.nav', 'Contacts'
    text_in_section '.nav', 'Tell Us?'
    text_in_section '.nav', 'Admin Login'
    
    # Check content of the <div> #title-section
    css_in_page '.title-section' 
    text_in_section '.title-section', "#{@dash_name} System Dashboard"
    text_in_section '.title-section', "Providing information about the status of #{@dash_name} systems"
    
    # Check content of the <div> #system-key
    css_in_page '#system-key' 
    
    ['green.png','red.png','amber.png'].each do |colour|
      image_in_section '#system-key', colour, 1
    end

    text_in_section '#system-key', 'No Major System Problems'
    text_in_section '#system-key', 'Priority 2 (P2) Incident Running Now'
    text_in_section '#system-key', 'Priority 1 (P1) Incident Running Now'
    
    # Check content of each <div> .main-section
    css_in_page '.main-section' 
    @system.each do |key, value|
      css_in_page "##{key}"
      case value.name
        when 'spock'
            check_system_section value.name, "No previous incidents recorded yet", 'amber.png' 
            text_in_section("##{key}", 'Incident Details')
        when 'kirk'
            check_system_section value.name, "No previous incidents recorded yet", 'green.png'         
            text_in_section("##{key}", 'Incident Details')
        when 'bones'
            check_system_section value.name, "1 Incident in the last 24 hours", 'green.png' #
            text_in_section("##{key}", 'Incident Details')
        when 'sulu'
            check_system_section value.name, "3 Days since the last incident", 'red.png'  
            text_in_section("##{key}", 'Incident Details')           
      end
    end
    
    # Check content of <p> system-last-refresh
    text_in_section('#system-last-refresh','Page last refreshed:')
  end

end  