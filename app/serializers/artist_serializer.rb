class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :firstName, :lastName, :biography, :additionalInfo, :created_at, :updated_at, :artist_image, :remove_artist_image
end
