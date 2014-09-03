require 'test_helper'

class CommentTest < ActiveSupport::TestCase
        
  test 'Model Validations' do
    # it's attribute :comment can not be blank
    comment=FactoryGirl.build :comment, comment: nil
    assert !comment.valid?, ':comment nil, should not be valid' 
    assert_equal comment.errors[:comment], ["can't be blank"] 

    comment=FactoryGirl.build :comment, comment: 'Test comment'
    assert comment.valid?, ':commnet OK, should be valid'  
  end  

  test 'Model Methods :save_comment(comment)' do
  	# Check when we supply real informtion we get the happy path
  	flash_hash=Hash.new
  	message='Hi there!'
  	flash_hash={notice: 'Your feedback has been saved. Thank you for your time and input!'}
  	comment=Comment.new comment: message
  	return_hash=comment.save_new_comment
  	assert_equal flash_hash, return_hash
  	assert_equal message, Comment.first.comment

  	# Check that when we enter nil we get the sad path
  	comment=Comment.new comment: nil
  	flash_hash={alert: 'Houston we have a problem! Please make sure you populate the text box with feedback?'}
  	return_hash=comment.save_new_comment
  	assert_equal flash_hash, return_hash
  end
  
end