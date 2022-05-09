class CreateVehicles < ActiveRecord::Migration[6.1]
  def change
    create_table :vehicles do |t|
      t.string :vin
      t.string :license_number_plate
      t.string :make
      t.string :model
      t.string :status

      t.timestamps
    end
  end
end
