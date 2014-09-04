class FlashMessage 

	def self.success(message)
		{notice: message}
	end

	def self.error(message)
		{alert: message}
	end

end
