class AddCustomTitleToArtwork < ActiveRecord::Migration[5.2]
  def change
    add_column :artworks, :custom_title, :string
  end
end
