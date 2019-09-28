class AddMultiFileToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :files, :json
  end
end
