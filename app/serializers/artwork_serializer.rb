class ArtworkSerializer < ActiveModel::Serializer
  attributes :id, :ojbId, :title, :medium, :created_at, :updated_at
end
