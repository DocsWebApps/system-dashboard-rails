# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  name            :string(255)
#  password_digest :string(255)
#  role_id         :integer
#  created_at      :datetime
#  updated_at      :datetime
#  auth_token      :string(255)
#

class User < ActiveRecord::Base
  # Define relationships
  belongs_to :role

  # Define callbacks
  has_secure_password
  before_save { |user| user.email = email.downcase }
  before_create :set_auth_token

  # Define validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true, length: { minimum: 8 }
  
  # Define proteted/private methods
  private
    def set_auth_token
      return if self.auth_token.present?
      self.auth_token=generate_auth_token
    end
    
    def generate_auth_token
      loop do
        token=SecureRandom.hex
        break token unless self.class.exists? auth_token: token
      end
    end
end