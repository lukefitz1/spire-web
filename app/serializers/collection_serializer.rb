class CollectionSerializer < ActiveModel::Serializer
  attributes :id, :collectionName, :artworks, :identifier, :customer_id, :created_at, :updated_at, :year

  belongs_to :customer
  has_many :artworks
end
