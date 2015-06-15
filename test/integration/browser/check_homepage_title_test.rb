require 'test_helper'

class CheckHomepageTitleTest < ActionDispatch::IntegrationTest
  
  def setup
    @dash_name=(FactoryGirl.create :company).name
    contact=FactoryGirl.create :contact
    visit root_path
  end
  
  def teardown
    DatabaseCleaner.clean
  end

  test 'Check the contents of the #title-section'  do
    # Check content of the <div> #title-section
    is_css_in_page? '#title-section' 
    is_text_in_section? '#title-section', "#{@dash_name} System Dashboard"
    is_text_in_section? '#title-section', "Providing information about the status of #{@dash_name} systems"
    is_text_in_section? '#title-section', 'Goto Dashboard'
  end
  
end