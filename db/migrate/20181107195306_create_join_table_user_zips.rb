class CreateJoinTableUserZips < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :zip_codes do |t|
      # t.index [:user_id, :zip_code_id]
      # t.index [:zip_code_id, :user_id]
    end
  end
end
