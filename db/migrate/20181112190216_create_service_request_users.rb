class CreateServiceRequestUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :service_request_users do |t|
      t.integer :service_request_id
      t.integer :user_id

      t.timestamps
    end
  end
end
