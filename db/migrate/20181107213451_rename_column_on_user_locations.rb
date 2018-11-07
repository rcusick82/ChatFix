class RenameColumnOnUserLocations < ActiveRecord::Migration[5.2]
  def change
    rename_column(:user_locations, :zip_code_id, :location_id)
  end
end
