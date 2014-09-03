require 'test_helper'

class ViewContacts_test < ActionDispatch::IntegrationTest
  
  def setup
    @dash_name=(FactoryGirl.create :company).name
    contact=FactoryGirl.create :contact
    @contact=contact.contact
    @message=contact.message
    visit root_path
    click_link 'Contacts'
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
    
    # Check the contents of the <div> .title-section
    css_in_page '.title-section' 
    text_in_section '.title-section', 'Contacts'  
    text_in_section '.title-section', 'Please choose from the contacts below.'
    
    # Check the contents of the <div> .main-section
    css_in_page '.main-section' 
    text_in_section '.main-section', @contact
    text_in_section '.main-section', @message
  end
  
end
