require 'test_helper'

class CheckHomepageContactsTest < ActionDispatch::IntegrationTest
  
  def setup
    @dash_name=(FactoryGirl.create :company).name
    contact=FactoryGirl.create :contact
    @contact=contact.contact
    @message=contact.message
    visit root_path
    click_link('Contacts')
  end
  
  def teardown
    DatabaseCleaner.clean
  end

  test 'Check the title of #contacts-section'  do  
    # Check the contents of the <div> .title-section
    is_css_in_page? '#contacts-section' 
    is_text_in_section? '#contacts-section', "#{@dash_name} Contact List"  
  end

  test 'Check the contents of the #contacts-section'  do
    # Check the contents of the <div>#contacts-section
    is_css_in_page? '#contacts-section' 
    is_text_in_section? '#contacts-section', @contact
    is_text_in_section? '#contacts-section', @message
  end

  test 'Check the copyright is present' do
    year=Date.today.year
    is_text_in_section? '#contacts-section', "&copy #{year} #{@dash_name}"
  end
  
end
