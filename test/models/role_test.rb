require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  
  def setup
    @role=FactoryGirl.create :role_with_users
  end
  
  test 'Testing Model Validations' do
    # it 'should have a :description value thats not nil or less than 20 characters long
      role=FactoryGirl.build :role, description: nil
      assert !role.valid?, ':description nil, should not be valid'
      assert_equal role.errors[:description],["can't be blank"]   
      
      role=FactoryGirl.build :role, description: set_string(21)
      assert !role.valid?, ':description > 20 chars, should not be valid'
      assert_equal role.errors[:description],["is too long (maximum is 20 characters)"]    
      
      role=FactoryGirl.build :role, name: 'myadmin', description: set_string(20)
      assert role.valid?, ':description OK, should be valid !'
    
    # it should have a :name value thats not nil, and both unique or less than 10 characters long
      role=FactoryGirl.build :role,  name: 'admin'
      assert !role.valid?, ':admin not unique, should not be valid'
      assert_equal role.errors[:name],["has already been taken"]
      
      role=FactoryGirl.build :role, name: nil
      assert !role.valid?, ':name is nil, should not be valid'
      assert_equal role.errors[:name],["can't be blank"]   
      
      role=FactoryGirl.build :role, name: set_string(11)
      assert !role.valid?, ':name > 10 chars, should not be valid'
      assert_equal role.errors[:name],["is too long (maximum is 10 characters)"]    
      
      role=FactoryGirl.build :role, name: set_string(10), description: 'Administrator role'
      assert role.valid?, ':name and :description OK, should be valid'     
  end
  
  test 'Testing Model Relationships' do
    # :Role should have a relationship with the model User
      assert_respond_to @role, :users
  end
end