class AddProposalsInvoicesImagesToCollections < ActiveRecord::Migration[5.1]
  def change
  	add_column :collections, :customer_proposals, :string, array: true
  	add_column :collections, :customer_invoices, :string, array: true
  	add_column :collections, :artist_image, :string, array: true
  end
end
