class AddCollectionRefToArtwork < ActiveRecord::Migration[5.1]
  def change
    add_reference :artworks, :collection, foreign_key: true
  end
end
