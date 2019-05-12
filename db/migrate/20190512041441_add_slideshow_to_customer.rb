class AddSlideshowToCustomer < ActiveRecord::Migration[5.1]
  def change
  	add_column :customers, :customer_photos, :string, array: true, default: []
  end
end
