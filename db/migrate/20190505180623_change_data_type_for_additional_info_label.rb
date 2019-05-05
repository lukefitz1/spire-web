class ChangeDataTypeForAdditionalInfoLabel < ActiveRecord::Migration[5.1]
  def change
  	change_column :additional_infos, :info_label, :string
  end
end
