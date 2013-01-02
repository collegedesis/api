class EventSerializer < ActiveModel::Serializer 
  attributes :id, :name, :organization_id, :date
end