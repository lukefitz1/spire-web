class AddCustomInfoToArtwork < ActiveRecord::Migration[5.2]
  def change
    add_column :artworks, :custom_details, :string
  end
end
