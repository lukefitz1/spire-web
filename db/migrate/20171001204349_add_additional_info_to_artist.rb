class AddAdditionalInfoToArtist < ActiveRecord::Migration[5.1]
  def change
  	add_column :artists, :additionalInfo, :string
  end
end
