require 'test_helper'

class CheckHomepageNavbarTest < ActionDispatch::IntegrationTest
  
  def setup
    @dash_name=(FactoryGirl.create :company).name
    contact=FactoryGirl.create :contact
    visit root_path
  end
  
  def teardown
    DatabaseCleaner.clean
  end

  test 'Check the contents of the navbar'  do
    # Check content of the <div> .nav
    css_in_page '.nav' 
    text_in_section '.navbar-brand', "System Dashboard"
    text_in_section '.navbar-nav', 'Dashboard'
    text_in_section '.navbar-nav', 'Contacts'
    text_in_section '.navbar-nav', 'Admin Login'
    text_in_section '.navbar-nav', 'Create New Incident', false
    text_in_section '.navbar-nav', 'Edit Existing Incident', false
  end
  
end