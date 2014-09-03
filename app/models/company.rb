# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Company < ActiveRecord::Base
	# Define relationships
  validates :name, presence: true, uniqueness: true
  
  # Define class methods
  def self.return_name
    @@company_name ||= Company.first.name
  end
end