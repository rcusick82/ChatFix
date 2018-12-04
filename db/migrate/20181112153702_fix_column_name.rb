class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :Phone_Number, :phone_number
  end
end
