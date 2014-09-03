# == Schema Information
#
# Table name: incidents
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

class Incident < ActiveRecord::Base
  # Define relationships 
  belongs_to :system

  # Define validations
  validates :date, :time, :description, presence: true
  validates :hp_ref, presence: true, uniqueness: {case_sensitive: false}
  validates :severity, presence: true, inclusion: %w(P1 P2 D) 
  validates :status, presence: true, inclusion: %w(Open Closed) 

  # Define class methods
  def self.no_open_incidents?
    where(status: 'Open').count==0 ? true : false
  end

  # Define instance methods
  def save_new_incident
    if self.save
      self.system.set_system_status
    else
      return false
    end
  end

  def update_existing_incident(incident_params)
    if self.update(incident_params)
      self.system.set_system_status
    else
      return false
    end
  end

  def close_or_downgrade_incident(query_param)
    success_message={notice: "Incident #{self.hp_ref} has been closed/downgraded successfully."}
    error_message={notice: 'Houston we have a problem! The close or downgrade operation failed for this incident.'}
    
    if query_param=='close' && self.close_incident
      success_message
    elsif query_param=='downgrade' && self.downgrade_incident
      success_message
    else
      error_message
    end
  end
  
  # Define protected/private methods
  protected
    def close_incident
      self.status='Closed'
      self.closed_at=Time.now
      self.save
      self.system.set_system_status
    end
  
    def downgrade_incident
      self.severity='D'
      self.close_incident
      self.system.incident_histories.create hp_ref: self.hp_ref, description: self.description, resolution: self.resolution, date: self.date, time: self.time, status: self.status, severity: self.severity, closed_at: self.closed_at
      self.delete
    end
end