# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  comment    :text
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
	# Define validations
  validates :comment, presence: true

  # Define public instance methods
  def save_new_comment
  	if self.save
  		FlashMessage.success('Your feedback has been saved. Thank you for your time and input!')
  	else
  		FlashMessage.error('Houston we have a problem! Please make sure you populate the text box with feedback?')
  	end
  end
  
end