class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :firstName, :lastName

  has_many :collections
end
