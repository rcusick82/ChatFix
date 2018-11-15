class CreateServiceRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :service_requests do |t|
      t.string :requestor_id
      t.string :vendor_id

      t.timestamps
    end
  end
end
