class SystemDecorator

	def initialize(system)
		@system=system
	end

  def set_message_and_message_color
    closed_incident_count=@system.incidents.where(status: 'Closed').count
    last_incident_date=@system.last_incident_date
    days_since_last_incident=(Date.today-last_incident_date).to_i if last_incident_date

    if (closed_incident_count>0)
      incident='Incident'.pluralize(closed_incident_count)
      return 'system-red',"#{closed_incident_count} #{incident} in the last 24 hours"
    elsif (last_incident_date==nil)
      return 'system-green', 'No previous incidents recorded yet'
    elsif (days_since_last_incident>0)
      day='Day'.pluralize(days_since_last_incident)
      return 'system-green', "#{days_since_last_incident} #{day} since the last incident"
    else
      return 'system-red', "Houston we have a problem!"
    end
  end

  def method_missing(method_name, *args, &block)
		@system.send(method_name, *args, &block)
	end

	def respond_to_missing?(method_name, include_private=false)
		@system.respond_to?(method_name, include_private) || super
	end

end