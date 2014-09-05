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

  # Define instance methods
  def check_closed_at_time
    archive_incident if closed_more_than_24_hours_ago
  end

  def save_new_incident
    if save
      check_system_status(self.system)
    else
      return false
    end
  end

  def update_existing_incident(incident_params)
    if update(incident_params)
      check_system_status(self.system)
    else
      return false
    end
  end

  def close_or_downgrade_incident(query_param)
    if query_param=='close' && close_incident
      FlashMessage.success("Incident #{self.hp_ref} has been closed successfully.")
    elsif query_param=='downgrade' && archive_incident(true)
      FlashMessage.success("Incident #{self.hp_ref} has been downgraded successfully.")
    else
      FlashMessage.error('Houston we have a problem! The close or downgrade operation failed for this incident.')
    end
  end
  
  # Define protected/private methods
  private
    def close_incident
      self.status='Closed'
      self.closed_at=Time.now
      save
      check_system_status(self.system)
    end

    def archive_incident(downgraded=false)
      system=self.system
      if downgraded
        self.severity='D'
        close_incident
      else
        system.update_last_incident_date(self.closed_at.to_date)
      end
      IncidentHistory.create_new_record(system, self)
      delete
    end

    def check_system_status(system)
      system.update_status
    end

    def closed_more_than_24_hours_ago
      Time.now > (self.closed_at + 24.hours)
    end
end