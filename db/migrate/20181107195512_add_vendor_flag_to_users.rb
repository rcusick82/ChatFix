class AddVendorFlagToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :vendor, :boolean, default: 'false'
  end
end
