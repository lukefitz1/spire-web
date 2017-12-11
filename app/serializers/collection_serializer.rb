class CollectionSerializer < ActiveModel::Serializer
  attributes :id, :collectionName, :artworks, :identifier, :created_at, :updated_at
end
