class RemoveClientArtistFromArtworks < ActiveRecord::Migration[5.1]
  def change
    remove_reference :artworks, :artists, foreign_key: true
    remove_reference :artworks, :customers, foreign_key: true
  end
end
