class DeleteAdditionalInfoTable < ActiveRecord::Migration[5.1]
  def change
  	drop_table :additional_infos
  end
end
