class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :fullname, :string
    add_column :users, :active, :boolean
    add_column :users, :dob, :date
    add_column :users, :nic, :string
    add_column :users, :email, :string
    add_column :users, :role, :string
    add_column :users, :phone, :string
    add_column :users, :vehicle_id, :string
    add_column :users, :onboarding_complete, :boolean
    add_column :users, :driver_license_number, :string
    add_column :users, :driver_license_state, :string
    add_column :users, :driver_eld_id, :string
  end
end
