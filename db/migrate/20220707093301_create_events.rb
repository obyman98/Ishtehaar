class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.decimal 'lat', precision: 10, scale: 6
      t.decimal 'lng', precision: 10, scale: 6
      t.integer 'ad_count'

      t.timestamps
    end

    add_reference :events, :eld, null: false, foreign_key: true
    add_reference :events, :ad, null: false, foreign_key: true
  end
end
