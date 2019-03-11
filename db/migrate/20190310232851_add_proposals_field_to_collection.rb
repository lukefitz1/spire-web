class AddProposalsFieldToCollection < ActiveRecord::Migration[5.1]
  def change
  	add_column :collections, :customer_proposals, :string, array: true, default: []
  end
end
