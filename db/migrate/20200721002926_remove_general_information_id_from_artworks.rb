class RemoveGeneralInformationIdFromArtworks < ActiveRecord::Migration[5.2]
  def change
    remove_column :artworks, :general_information_id, :string
  end
end
