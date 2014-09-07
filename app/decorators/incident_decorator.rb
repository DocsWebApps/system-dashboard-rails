class IncidentDecorator

	def initialize(incident=nil)
		@incident=incident
	end

  def list_systems
    System.order(:id)
  end

	def check_for_open_incidents?(system=nil)
		query=Incident.where(status: 'Open')
		query=system.incidents.where(status: 'Open') if system
		query.count>0 ? true : false
  end

  def method_missing(method_name, *args, &block)
		@incident.send(method_name, *args, &block)
	end

	def respond_to_missing?(method_name, include_private=false)
		@incident.respond_to?(method_name, include_private) || super
	end

end