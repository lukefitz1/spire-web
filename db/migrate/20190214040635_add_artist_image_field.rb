class AddArtistImageField < ActiveRecord::Migration[5.1]
  def change
  	add_column :artists, :artist_image, :string
  end
end
