class RenameZipCodesTable < ActiveRecord::Migration[5.2]
  def change
    rename_table(:zip_codes, :locations)
    rename_column(:locations, :zip_codes, :zip_code)
  end
end
