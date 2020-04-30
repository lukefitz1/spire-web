class AddProvenanceImageToArtwork < ActiveRecord::Migration[5.2]
  def change
    add_column :artworks, :provenance_image, :string
  end
end
