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

require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  
  test 'Model Validations' do
    # it's attributes :contact and :message can not be blank
      contact=FactoryGirl.build :contact, contact: nil, message: nil
      assert !contact.valid?, ':contact nil && :message nil, should not be valid'
      assert_equal contact.errors[:contact], ["can't be blank"]
      assert_equal contact.errors[:message], ["can't be blank"]
    
      contact=FactoryGirl.build :contact, contact: 'email@email.com', message: 'Test message'
      assert contact.valid?, ':contact && :message OK, should be valid'
  end
  
end
