class ChangeArrayColumnsToHaveDefaultEmptyArray < ActiveRecord::Migration[5.1]
  def change
  	change_column :collections, :customer_proposals, :string, array: true, default: []
  	change_column :collections, :customer_invoices, :string, array: true, default: []
  	change_column :collections, :additional_photos, :string, array: true, default: []
  end
end
