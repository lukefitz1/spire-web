class AddCustomerArtistRefToArtworks < ActiveRecord::Migration[5.1]
  def change
    add_reference :artworks, :artist, foreign_key: true
    add_reference :artworks, :customer, foreign_key: true
  end
end
