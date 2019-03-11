class ChangeCollectionColumnName < ActiveRecord::Migration[5.1]
  def change
  	rename_column :collections, :artist_image, :additional_photos
  end
end
