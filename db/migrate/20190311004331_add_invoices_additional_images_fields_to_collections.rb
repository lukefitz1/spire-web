class AddInvoicesAdditionalImagesFieldsToCollections < ActiveRecord::Migration[5.1]
  def change
  	add_column :collections, :customer_invoices, :string, array: true, default: []
  	add_column :collections, :additional_photos, :string, array: true, default: []
  end
end
