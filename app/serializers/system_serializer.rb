class SystemSerializer < ActiveModel::Serializer
  attributes :id, :name, :status

  def attributes
  	data=super
  	decorator=SystemDecorator.new object
  	data[:color], data[:message]=decorator.set_message_and_message_color
  	data
  end

end
