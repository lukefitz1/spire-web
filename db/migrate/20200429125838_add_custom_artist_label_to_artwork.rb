class AddCustomArtistLabelToArtwork < ActiveRecord::Migration[5.2]
  def change
    add_column :artworks, :custom_artist_label, :string
  end
end
