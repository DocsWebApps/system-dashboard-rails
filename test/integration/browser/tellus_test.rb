require 'test_helper'

class ViewTellusTest < ActionDispatch::IntegrationTest
  
  def setup
    @dash_name=(FactoryGirl.create :company).name
    FactoryGirl.create :system
    visit root_path
    click_link 'Tell Us?'
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
    text_in_section('.title-section', 'Tell Us?')
    text_in_section('.title-section', "Please use the form below to tell us about your experience working with #{@dash_name}")
    text_in_section('.title-section','The feedback is completely anonymous and so please be both open and frank!')
    
    # Check the comment entry form and message are in the <div> #form-tellus section
    css_in_page('#form-tellus')
    text_in_section('#form-tellus', 'Please enter your feedback below and press the submit button.')
    
    # Check the form takes and entry and stores it to the database
    comment='Test comment'
    fill_in 'comment_comment', with: comment
    click_button 'Submit Feedback'
    text_in_section '.flash-notice', 'Your feedback has been saved. Thank you for your time and input!'
    assert_equal comment, Comment.first.comment

    # Check the form return the right error message when no data is entered
    Comment.delete_all
    fill_in 'comment_comment', with: nil
    click_button 'Submit Feedback'
    text_in_section '.flash-alert', 'Houston we have a problem! Please make sure you populate the text box with feedback?'
    assert_equal 0, Comment.all.count
  end
  
end