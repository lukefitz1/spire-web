class CollectionSerializer < ActiveModel::Serializer
  attributes :id, :collectionName, :artworks, :created_at, :updated_at
end
