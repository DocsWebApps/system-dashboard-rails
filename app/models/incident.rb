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

  def self.open_incident_count(system, severity)
    system.incidents.where(severity: severity, status: 'Open').count
  end 

  # Define instance methods
  def check_closed_at_time
    archive_incident if (Time.now > (self.closed_at + 24.hours))
  end

  def archive_incident
    self.system.incident_histories.create hp_ref: self.hp_ref, title: self.title, time: self.time , date: self.date, status: self.status, severity: self.severity, description: self.description, resolution: self.resolution, closed_at: self.closed_at
    self.system.update_last_incident_date(self.closed_at.to_date)
    self.delete
  end

  def save_new_incident
    if self.save
      check_system_status(self.system)
    else
      return false
    end
  end

  def update_existing_incident(incident_params)
    if self.update(incident_params)
      check_system_status(self.system)
    else
      return false
    end
  end

  def close_or_downgrade_incident(query_param)
    if query_param=='close' && self.close_incident
      FlashMessage.success("Incident #{self.hp_ref} has been closed successfully.")
    elsif query_param=='downgrade' && self.downgrade_incident
      FlashMessage.success("Incident #{self.hp_ref} has been downgraded successfully.")
    else
      FlashMessage.error('Houston we have a problem! The close or downgrade operation failed for this incident.')
    end
  end
  
  # Define protected/private methods
  protected
    def close_incident
      self.status='Closed'
      self.closed_at=Time.now
      self.save
      check_system_status(self.system)
    end
  
    def downgrade_incident
      self.severity='D'
      self.close_incident
      self.system.incident_histories.create hp_ref: self.hp_ref, description: self.description, resolution: self.resolution, date: self.date, time: self.time, status: self.status, severity: self.severity, closed_at: self.closed_at
      self.delete
    end

  private
    def check_system_status(system)
      system.update_status
    end
end