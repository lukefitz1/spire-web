class AddShowInfoCheckToArtwork < ActiveRecord::Migration[5.1]
  def change
  	add_column :artworks, :show_general_info, :boolean
  end
end
