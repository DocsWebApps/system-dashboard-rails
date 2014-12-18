# == Schema Information
#
# Table name: incident_histories
#
#  id          :integer          not null, primary key
#  hp_ref      :string(255)
#  description :text
#  resolution  :text
#  date        :date
#  status      :string(255)
#  system_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#  title       :text
#  severity    :string(255)
#  time        :time
#  closed_at   :datetime
#

class IncidentHistory < ActiveRecord::Base
	# Define relationships
  belongs_to :system

  # Define validations
  validates :date, :time, :description, presence: true
  validates :hp_ref, presence: true, uniqueness: {case_sensitive: false}
  validates :severity, presence: true, inclusion: %w(P1 P2 D) 
  validates :status, presence: true, inclusion: %w(Open Closed) 
  validates :closed_at, presence: true

  # Define class methods
  def self.create_new_record(system, incident)
  	system.incident_histories.create hp_ref: incident.hp_ref, time: incident.time , date: incident.date, status: incident.status, severity: incident.severity, description: incident.description, closed_at: incident.closed_at
	end

end