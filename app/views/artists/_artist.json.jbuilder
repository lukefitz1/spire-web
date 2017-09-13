json.extract! artist, :id, :firstName, :lastName, :biography, :created_at, :updated_at
json.url artist_url(artist, format: :json)
