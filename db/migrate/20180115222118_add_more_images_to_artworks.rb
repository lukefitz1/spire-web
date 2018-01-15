class AddMoreImagesToArtworks < ActiveRecord::Migration[5.1]
  def change
  	add_column :artworks, :notesImageTwo, :string
  	add_column :artworks, :additionalInfoImageTwo, :string
  end
end
