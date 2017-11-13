class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :firstName, :lastName, :created_at, :updated_at

  has_many :collections
end
