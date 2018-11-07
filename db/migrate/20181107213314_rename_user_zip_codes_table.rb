class RenameUserZipCodesTable < ActiveRecord::Migration[5.2]
  def change
    rename_table(:user_zip_codes, :user_locations)
  end
end
