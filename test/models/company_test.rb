require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  
  def setup 
    @company=FactoryGirl.create :company
    @name=@company.name
  end
       
  test 'Model Validations' do
    # it's attribute :name can not be blank
      company=FactoryGirl.build :company, name: nil
      assert !company.valid?, ':name nil, should not be valid'
    
      company=FactoryGirl.build :company, name: 'Test company'
      assert company.valid?, ':name OK, should be valid'
          
    # it's attribute :name must be unique
      company=FactoryGirl.build :company, name: @name
      assert !company.valid?, ':name already taken, should not be valid'
  end
  
  test 'Model Methods' do
    # it's method Company.return_name must return the :name attribute
      assert_equal Company.return_name, @name
  end
  
end 