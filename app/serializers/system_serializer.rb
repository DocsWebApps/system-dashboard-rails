class SystemSerializer < ActiveModel::Serializer
  attributes :name, :status

  #has_many :incidents
  #has_many :incident_histories
end
