class AddDateAcquiredLabelToArtwork < ActiveRecord::Migration[5.1]
  def change
  	add_column :artworks, :dateAcquiredLabel, :string
  end
end
