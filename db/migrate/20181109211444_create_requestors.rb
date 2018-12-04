class CreateRequestors < ActiveRecord::Migration[5.2]
  def change
    create_table :requestors do |t|
      t.string :phone_number

      t.timestamps
    end
  end
end
