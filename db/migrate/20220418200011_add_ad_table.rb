class AddAdTable < ActiveRecord::Migration[6.1]
  def change
    create_table :ads do |t|
      # t.attachment :ad
      t.string :title
      t.string :status
      t.string :comment
      t.integer :count
      t.date :schedule_date_start
      t.date :schedule_date_end

      t.timestamps
    end
  end
end