class AddIncludeArtistAndGeneralInfoCheckToArtwork < ActiveRecord::Migration[5.2]
  def change
    add_column :artworks, :include_artist_and_general_info, :boolean
  end
end
