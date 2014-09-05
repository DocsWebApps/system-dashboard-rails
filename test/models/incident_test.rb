require 'test_helper'

class IncidentTest < ActiveSupport::TestCase
  
  def setup
    @system=FactoryGirl.create :system_with_incidents
    @system.update_status
    @hp_ref=@system.incidents.first.hp_ref
    @hp_ref_unique=@hp_ref+'X'
  end

  test 'Testing Model Method :check_closed_at_time' do
    incident=@system.incidents.first
    incident.status='Closed'
    incident.closed_at=Time.now - 24.hours
    incident.save
    incident.check_closed_at_time
    assert_equal 0, @system.incidents.count
    assert_equal 2, @system.incident_histories.count
  end
  
  test 'Testing Model Method :close_or_downgrade_incident(close)' do
    # it should close the incident when :close_or_downgrade_incident is called
    incident=@system.incidents.first
    assert_equal 'Open', incident.status
    success_message={notice: "Incident #{@hp_ref} has been closed successfully."}
    flash_message=incident.close_or_downgrade_incident('close')
    assert_equal 'Closed', incident.status
    assert_equal success_message, flash_message
  end

  test 'Testing Model Method :close_or_downgrade_incident(downgrade)' do   
    # it should downgrade the incident when :close_or_downgrade_incident is called
    incident=@system.incidents.first
    assert_equal 'Open', incident.status
    success_message={notice: "Incident #{@hp_ref} has been downgraded successfully."}    
    flash_message=incident.close_or_downgrade_incident('downgrade')
    assert_equal 'Closed', incident.status
    assert_equal 'D', incident.severity
    assert_equal success_message, flash_message
  end
  
  test 'Testing Model Relationships' do
    # :Incident should have a relationship with :System
    incident=@system.incidents.first
    assert_respond_to incident, :system
  end
  
  test 'Testing Model Validations' do
    # it's attributes :title, :date, :time, :status, :description, :hp_ref, :severity, :status can not be blank
    incident=FactoryGirl.build :incident, hp_ref: nil, time: nil, date: nil, status: nil, severity: nil, description: nil
    assert !incident.valid?, ':hp_ref nil, :time nil, :date nil, :status nil, :severity nil, :description nil, should not be valid'
    assert_equal incident.errors[:hp_ref],["can't be blank"]
    assert_equal incident.errors[:time],["can't be blank"]
    assert_equal incident.errors[:date],["can't be blank"]
    assert_equal incident.errors[:status],["can't be blank", "is not included in the list"]
    assert_equal incident.errors[:severity],["can't be blank", "is not included in the list"]
    assert_equal incident.errors[:description],["can't be blank"]
    
    # it should have a unique value for :hp_ref
    hp_ref=@system.incidents.first.hp_ref
    incident=FactoryGirl.build :incident, hp_ref: hp_ref
    assert !incident.valid?, ':hp_ref already taken, should not be valid'
    assert_equal incident.errors[:hp_ref],["has already been taken"]
    
    # it's status value should be constrained to :Open or :Closed
    incident=FactoryGirl.build :incident, status: 'Open', hp_ref: @hp_ref_unique
    assert incident.valid?, 'can only be :Open or :Closed, should be valid'
      
    incident=FactoryGirl.build :incident, status: 'Closed', hp_ref: @hp_ref_unique
    assert incident.valid?, 'can only be :Open or :Closed, should be valid'
      
    incident=FactoryGirl.build :incident, status: 'a', hp_ref: @hp_ref_unique
    assert !incident.valid?, 'can only be :Open or :Closed, should not be valid'

    # it's severity value should be constrained to :P1, :P2 OR :D
    incident=FactoryGirl.build :incident, severity: 'P1', hp_ref: @hp_ref_unique
    assert incident.valid?, 'can only be :P1, :P2 OR :D, should be valid'
      
    incident=FactoryGirl.build :incident, severity: 'P2', hp_ref: @hp_ref_unique
    assert incident.valid?, 'can only be :P1, :P2 OR :D, should be valid'

    incident=FactoryGirl.build :incident, severity: 'D', hp_ref: @hp_ref_unique
    assert incident.valid?, 'can only be :P1, :P2 OR :D, should be valid'
      
    incident=FactoryGirl.build :incident, severity: 'a', hp_ref: @hp_ref_unique
    assert !incident.valid?, 'can only be :P1, :P2 OR :D, should not be valid'
  end
    
end