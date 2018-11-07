class RenameUsersZipCodesTable < ActiveRecord::Migration[5.2]
  def change
    rename_table(:users_zip_codes, :user_zip_codes)
  end
end
