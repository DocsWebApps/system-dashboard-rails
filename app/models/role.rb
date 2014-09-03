# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Role < ActiveRecord::Base
	# Define relationships	
  has_many :users

  # Define validations
  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: { maximum: 10 }
  validates :description, presence: true, length: { maximum: 20 }
end