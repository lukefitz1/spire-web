class RemoveArtistIdFromArtworks < ActiveRecord::Migration[5.2]
  def change
    remove_column :artworks, :artist_id, :string
  end
end
