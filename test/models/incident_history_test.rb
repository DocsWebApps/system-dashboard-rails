# == Schema Information
#
# Table name: incident_histories
#
#  id          :integer          not null, primary key
#  fault_ref   :string(255)
#  description :text
#  date        :date
#  status      :string(255)
#  system_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#  severity    :string(255)
#  time        :time
#  closed_at   :datetime
#

require 'test_helper'

class IncidentHistoryTest < ActiveSupport::TestCase
  
  def setup 
    @system=FactoryGirl.create :system_with_incidents
    @system.update_status
    @fault_ref_unique=@system.incident_histories.first.fault_ref+'X'
  end

  test 'Testing Model Methods :create_new_record(system, incident)' do
    incident=@system.incidents.first
    assert_equal 1, IncidentHistory.all.count
    IncidentHistory.create_new_record(@system, incident)
    #assert_equal 2, IncidentHistory.all.count
  end
  
  test 'Testing Model Relationships' do
    # :Incident should have a relationship with :System
      incident=@system.incident_histories.first
      assert_respond_to incident, :system
  end
  
  test 'Testing Model Validations' do
    # it's attributes :title, :date, :time, :status, :description, :fault_ref, :severity, :status, :closed_at can not be blank
      incident=FactoryGirl.build :incident_history, fault_ref: nil, time: nil, date: nil, status: nil, severity: nil, description: nil, closed_at: nil
      assert !incident.valid?, ':fault_ref nil, :time nil, :date nil, :status nil, :severity nil, :description nil, :closed_at nil, should not be valid'
      assert_equal incident.errors[:fault_ref],["can't be blank"]
      assert_equal incident.errors[:time],["can't be blank"]
      assert_equal incident.errors[:date],["can't be blank"]
      assert_equal incident.errors[:status],["can't be blank", "is not included in the list"]
      assert_equal incident.errors[:severity],["can't be blank", "is not included in the list"]
      assert_equal incident.errors[:description],["can't be blank"]
      assert_equal incident.errors[:closed_at], ["can't be blank"]
    
    # it should have a unique value for :fault_ref
      fault_ref=@system.incident_histories.first.fault_ref
      incident=FactoryGirl.build :incident_history, fault_ref: fault_ref
      assert !incident.valid?, ':fault_ref has already be taken, should not be valid'
      assert_equal incident.errors[:fault_ref],["has already been taken"]
    
    # it's status value should be constrained to :Open or :Closed
      incident=FactoryGirl.build :incident_history, status: 'Open', fault_ref: @fault_ref_unique
      assert incident.valid?, 'can only be :Open or :Closed, should be valid'
      
      incident=FactoryGirl.build :incident_history, status: 'Closed', fault_ref: @fault_ref_unique
      assert incident.valid?, 'can only be :Open or :Closed, should be valid'
      
      incident=FactoryGirl.build :incident_history, status: 'a', fault_ref: @fault_ref_unique
      assert !incident.valid?, 'can only be :Open or :Closed, should not be valid'
    
    # it's severity value should be constrained to :P1,:P2 or :D
      incident=FactoryGirl.build :incident_history, severity: 'P1', fault_ref: @fault_ref_unique
      assert incident.valid?, 'can only be :D, :P1 or :P2, should be valid'
      
      incident=FactoryGirl.build :incident_history, severity: 'P2', fault_ref: @fault_ref_unique
      assert incident.valid?, 'can only be :P1 or :P2, should be valid'
      
      incident=FactoryGirl.build :incident_history, severity: 'D', fault_ref: @fault_ref_unique
      assert incident.valid?, 'can only be :D, :P1 or :P2, should be valid'
      
      incident=FactoryGirl.build :incident_history,  severity: 'a', fault_ref: @fault_ref_unique
      assert !incident.valid?, 'can only be :D, :P1 or :P2, should not be valid'
  end
  
end
