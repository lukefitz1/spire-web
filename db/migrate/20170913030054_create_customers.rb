class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :firstName
      t.string :lastName
      t.string :collectionName

      t.timestamps
    end
  end
end
