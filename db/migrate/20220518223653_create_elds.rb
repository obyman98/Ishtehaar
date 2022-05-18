class CreateElds < ActiveRecord::Migration[6.1]
  def change
    create_table :elds do |t|
      t.text :identifier
      t.text :mac_address
      t.text :wifi_ssid
      t.string :password_digest

      t.timestamps
    end

    add_reference :elds, :user, null: false, foreign_key: true
  end
end