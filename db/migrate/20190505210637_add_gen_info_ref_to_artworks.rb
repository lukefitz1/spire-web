class AddGenInfoRefToArtworks < ActiveRecord::Migration[5.1]
  def change
  	add_reference :artworks, :general_information, type: :uuid, foreign_key: true
  end
end
