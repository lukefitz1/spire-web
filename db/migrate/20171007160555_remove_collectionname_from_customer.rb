class RemoveCollectionnameFromCustomer < ActiveRecord::Migration[5.1]
  def change
    remove_column :customers, :collectionName, :string
  end
end
