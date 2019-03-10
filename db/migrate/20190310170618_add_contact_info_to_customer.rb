class AddContactInfoToCustomer < ActiveRecord::Migration[5.1]
  def change
  	add_column :customers, :email_address, :string
  	add_column :customers, :phone_number, :string
  	add_column :customers, :street_address, :string
  	add_column :customers, :city, :string
  	add_column :customers, :state, :string
  	add_column :customers, :zip, :string
  end
end
