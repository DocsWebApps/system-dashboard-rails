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
    css_in_page '#contacts-section' 
    text_in_section '#contacts-section', "#{@dash_name} Contact List"  
  end

  test 'Check the contents of the #contacts-section'  do
    # Check the contents of the <div>#contacts-section
    css_in_page '#contacts-section' 
    text_in_section '#contacts-section', @contact
    text_in_section '#contacts-section', @message
  end

  test 'Check the copyright is present' do
    text_in_section '#contacts-section', "&copy 2014 #{@dash_name}"
  end
  
end
