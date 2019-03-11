class RemoveNewCollectionFields < ActiveRecord::Migration[5.1]
  def change
  	remove_column :collections, :customer_proposals, :string
  	remove_column :collections, :customer_invoices, :string
  	remove_column :collections, :additional_photos, :string
  end
end
