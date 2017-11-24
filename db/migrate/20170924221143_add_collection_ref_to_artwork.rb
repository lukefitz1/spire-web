class AddCollectionRefToArtwork < ActiveRecord::Migration[5.1]
  def change
    add_reference :artworks, :collection, type: :uuid, foreign_key: true
  end
end
