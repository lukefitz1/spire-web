class AddProjectNotesReferredByToCustomer < ActiveRecord::Migration[5.1]
  def change
  	add_column :customers, :referred_by, :string
  	add_column :customers, :project_notes, :text
  end
end
