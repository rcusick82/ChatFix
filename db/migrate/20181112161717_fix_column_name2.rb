class FixColumnName2 < ActiveRecord::Migration[5.2]
  def change
    rename_column :service_requests, :vendor_id, :user_id
  end
end
