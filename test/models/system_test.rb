# == Schema Information
#
# Table name: systems
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  status             :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  row_id             :integer
#  last_incident_date :date
#

require 'test_helper'

class SystemTest < ActiveSupport::TestCase
  
  def setup
    @system=FactoryGirl.create :system_with_incidents
    @system.update_status
    @incident=@system.incidents.first
  end
  
  test 'Model Validations' do
    # it should always have a valid :name, :status and :row_id, they can not be blank 
    system=System.new name: nil, status: nil, row_id: nil
    assert !system.valid?, ':name nil, :status, :row_id nil, should not be valid'
    assert_equal ["can't be blank"], system.errors[:name]
    assert_equal ["can't be blank"], system.errors[:row_id]
    assert_equal ["can't be blank"], system.errors[:status]
 
    system=System.new name: 'spock', status: 'green', row_id: 1
    assert system.valid?, 'should be valid'
    
    # it should have a unique :name no greater than 30 characters
    system=System.new name: 'kirk'
    assert !system.valid?, ':name already been taken, should not be valid'
    assert_equal ["has already been taken"], system.errors[:name]
      
    system=System.new name: set_string(30), status: 'green', row_id: 1
    assert system.valid?, ':name OK and should be valid'
      
    system=System.new name: set_string(31), status: 'green', row_id: 1
    assert !system.valid?, ':name too long, should not be valid' 
    assert_equal ["is too long (maximum is 30 characters)"], system.errors[:name]  

    # it should have a :status no greater than 5 characters 
    system=System.new name: set_string(30), status: set_string(5), row_id: 1
    assert system.valid?, ':status OK and should be valid'
      
    system=System.new name: set_string(30), status: set_string(6), row_id: 1
    assert !system.valid?, ':status too long, should not be valid' 
    assert_equal ["is too long (maximum is 5 characters)"], system.errors[:status] 
  end
  
  test 'Model Relationships' do
    # :System should have a relationionship with :Incident and :IncidentHistory
    assert_respond_to @system, :incidents
    assert_respond_to @system, :incident_histories
  end

  test 'Model Relationships, dependent: :destroy should work!' do
    # Delete a system and the incident and incident history for that system should also be deleted
    assert_equal 1, @system.incidents.count
    assert_equal 1, @system.incident_histories.count
    @system.destroy
    assert_equal 0, @system.incidents.count
    assert_equal 0, @system.incident_histories.count
  end
  
  test 'Model Scopes :system_list_for_row(row_id)' do
    # it should return the correct number of systems per row when calling :system_list_for_row(row_id)
    System.delete_all
    2.times do |num|
      FactoryGirl.create :system, name: "MySystem#{num}", row_id: 1
    end
      
    5.times do |num|
      FactoryGirl.create :system, name: "System#{num}", row_id: 2
    end
      
    assert_equal 2, System.system_list_for_row(1).count
    assert_equal 5, System.system_list_for_row(2).count
  end

  test 'Model Methods :update_last_incident_date' do
    last_incident_date=Date.parse('01/01/2014')
    @system.update_last_incident_date(last_incident_date)
    assert_equal last_incident_date, @system.last_incident_date
  end

  test 'Model Methods :update_status' do
    # Check that the status of a system is correctly set based on what incidents are open
    assert_equal 'amber', @system.status
    @incident.update(severity: 'P1')
    @system.update_status
    assert_equal 'red', @system.status
    @incident.update(status: 'Closed')
    @system.update_status
    assert_equal 'green', @system.status
  end
  
  test 'Model Methods :check_for_closed_incidents' do
    # It should move incidents closed over 24 hours ago from the incidents table to the incident_histories table
    # and set the last_incident_date on System to the closed_at date
    IncidentHistory.delete_all

    # Check system shows that we only have one P2 incident with no history
    assert_equal 0, @system.incidents.where(status: 'Open', severity: 'P1').count
    assert_equal 1, @system.incidents.where(status: 'Open', severity: 'P2').count
    assert_equal 0, @system.incident_histories.count

    # Close incident, move the time forward 24 hours and run the method :check_for_closed_incidents
    @incident.update(status: 'Closed', closed_at: Time.now)
    new_closed_at=@incident.closed_at-=24.hours
    @incident.save
    @system.check_for_closed_incidents
      
    # Check the incident is no longer in the incident table and is now in the incident history table
    assert_equal 0, @system.incidents.count
    assert_equal 1, @system.incident_histories.count

    # Check last_incident_date equals the closed date
    assert_equal new_closed_at.to_date, @system.last_incident_date
  end
  
end
