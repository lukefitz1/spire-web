class CollectionSerializer < ActiveModel::Serializer
  attributes :id, :collectionName, :artworks, :identifier, :customer_id, :created_at, :updated_at
end
