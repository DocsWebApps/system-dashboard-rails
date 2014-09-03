# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  contact    :string(255)
#  message    :text
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ActiveRecord::Base
	# Define validations
  validates :contact, :message, presence: true
end