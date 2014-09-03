require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @role=FactoryGirl.create :role_with_users
    @user=@role.users.first
  end
  
  test 'Testing Model Methods' do
    # it should create a auth_token when a new user is created
      assert @user.auth_token!=nil
  end
  
  test 'Testing Model Relationships' do
    # :User should have a relationship with :Role
      assert_respond_to @user, :role
  end
  
  test 'Testing Model Validations' do   
    # it should not be valid without a :name, :email, :password_digest and :password_confirmation
      user=@role.users.new name: nil, email: nil, password: nil, password_confirmation: nil
      assert !user.valid?, 'name: nil, email: nil, password: nil, password_confirmation: nil, should not be valid'
      assert_equal user.errors[:name], ["can't be blank"]
      assert_equal user.errors[:email], ["can't be blank", "is invalid"]
      assert_equal user.errors[:password], ["can't be blank", "can't be blank", "is too short (minimum is 8 characters)"]
      assert_equal user.errors[:password_confirmation], ["can't be blank", "is too short (minimum is 8 characters)"]
   
   # it should have a :name < 50 characters long   
      user=@role.users.new name: set_string(50), email: 'test1@testmail.com', password: set_string(8), password_confirmation: set_string(8)
      assert user.valid?, 'name: 50 chars, should be valid'
    
      user=@role.users.new name: set_string(51), email: 'test1@testmail.com', password: set_string(8), password_confirmation: set_string(8)
      assert !user.valid?, 'name: > 50 chars, should not be valid'
      assert_equal user.errors[:name], ["is too long (maximum is 50 characters)"]    
    
    # it should have an email thats unique and conforms to the following REGEX (/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
      user=@role.users.new name: 'Test User', email: @user.email, password: set_string(8), password_confirmation: set_string(8)
      assert !user.valid?, ':email already taken, should not be valid'
      assert_equal user.errors[:email],["has already been taken"]        
      
      user=@role.users.new name: 'Test User', email: 'test', password: set_string(8), password_confirmation: set_string(8)
      assert !user.valid?, ':email not valid, should not be valid'
      assert_equal user.errors[:email],["is invalid"]  
      
      user=@role.users.new name: 'Test User', email: 'test123@123.com', password: set_string(8), password_confirmation: set_string(8)
      assert user.valid?, ':email OK, should be valid !'        
    
    #it should have a :password 8 or more characters long
      user=@role.users.new name: 'Test User',email: 'test2@testmail.com', password: set_string(8), password_confirmation: set_string(8)
      assert user.valid?, ':paswword OK, should be valid' 
      
      user=@role.users.new name: 'Test User',email: 'test2@testmail.com', password: set_string(7), password_confirmation: set_string(7)
      assert !user.valid?, ':pasword too short, should not be valid'    
  end
end


