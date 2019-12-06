class AddBucketNameToCollections < ActiveRecord::Migration[5.2]
  def change
    add_column :collections, :bucket_name, :string
  end
end
