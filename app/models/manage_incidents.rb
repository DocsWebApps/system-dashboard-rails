class ManageIncidents

  # Define public instance methods
  def check_for_closed_incidents
    incidents.where(status: 'Closed').each(&:check_closed_at_time)
  end

  def update_last_incident_date(date)
    self.last_incident_date=date
    save
  end

  def update_status
    if incidents.where(status: 'Open', severity: 'P1').count > 0
      self.status='red'
    elsif incidents.where(status: 'Open', severity: 'P2').count > 0
      self.status='amber'
    else
      self.status='green'
    end
    save
  end

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

  def close_or_delete_incident(query_param)
    if query_param=='close' && close_incident
      FlashMessage.success("Incident #{self.fault_ref} has been closed successfully.")
    elsif query_param=='delete' && delete_incident
      FlashMessage.success("Incident #{self.fault_ref} has been deleted successfully.")
    else
      FlashMessage.error('Houston we have a problem! The close or delete operation failed for this incident.')
      return false
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

    def delete_incident
      delete
      check_system_status(self.system)
    end

    def archive_incident
      system=self.system
      system.update_last_incident_date(self.closed_at.to_date)
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