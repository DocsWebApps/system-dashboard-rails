require 'test_helper'

class IncidentHistoryTest < ActiveSupport::TestCase
  
  def setup 
    @system=FactoryGirl.create :system_with_incidents
    @system.update_status
    @hp_ref_unique=@system.incident_histories.first.hp_ref+'X'
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
    # it's attributes :title, :date, :time, :status, :description, :hp_ref, :severity, :status, :closed_at can not be blank
      incident=FactoryGirl.build :incident_history, hp_ref: nil, time: nil, date: nil, status: nil, severity: nil, description: nil, closed_at: nil
      assert !incident.valid?, ':hp_ref nil, :time nil, :date nil, :status nil, :severity nil, :description nil, :closed_at nil, should not be valid'
      assert_equal incident.errors[:hp_ref],["can't be blank"]
      assert_equal incident.errors[:time],["can't be blank"]
      assert_equal incident.errors[:date],["can't be blank"]
      assert_equal incident.errors[:status],["can't be blank", "is not included in the list"]
      assert_equal incident.errors[:severity],["can't be blank", "is not included in the list"]
      assert_equal incident.errors[:description],["can't be blank"]
      assert_equal incident.errors[:closed_at], ["can't be blank"]
    
    # it should have a unique value for :hp_ref
      hp_ref=@system.incident_histories.first.hp_ref
      incident=FactoryGirl.build :incident_history, hp_ref: hp_ref
      assert !incident.valid?, ':hp_ref has already be taken, should not be valid'
      assert_equal incident.errors[:hp_ref],["has already been taken"]
    
    # it's status value should be constrained to :Open or :Closed
      incident=FactoryGirl.build :incident_history, status: 'Open', hp_ref: @hp_ref_unique
      assert incident.valid?, 'can only be :Open or :Closed, should be valid'
      
      incident=FactoryGirl.build :incident_history, status: 'Closed', hp_ref: @hp_ref_unique
      assert incident.valid?, 'can only be :Open or :Closed, should be valid'
      
      incident=FactoryGirl.build :incident_history, status: 'a', hp_ref: @hp_ref_unique
      assert !incident.valid?, 'can only be :Open or :Closed, should not be valid'
    
    # it's severity value should be constrained to :P1,:P2 or :D
      incident=FactoryGirl.build :incident_history, severity: 'P1', hp_ref: @hp_ref_unique
      assert incident.valid?, 'can only be :D, :P1 or :P2, should be valid'
      
      incident=FactoryGirl.build :incident_history, severity: 'P2', hp_ref: @hp_ref_unique
      assert incident.valid?, 'can only be :P1 or :P2, should be valid'
      
      incident=FactoryGirl.build :incident_history, severity: 'D', hp_ref: @hp_ref_unique
      assert incident.valid?, 'can only be :D, :P1 or :P2, should be valid'
      
      incident=FactoryGirl.build :incident_history,  severity: 'a', hp_ref: @hp_ref_unique
      assert !incident.valid?, 'can only be :D, :P1 or :P2, should not be valid'
  end
  
end