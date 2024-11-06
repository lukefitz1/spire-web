class AddEmptyArtistToArtwork < ActiveRecord::Migration[7.0]
  def change
    add_column :artworks, :empty_artist, :boolean
  end
end
