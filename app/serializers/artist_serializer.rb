class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :firstName, :lastName, :biography
end
