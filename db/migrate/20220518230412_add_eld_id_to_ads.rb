class AddEldIdToAds < ActiveRecord::Migration[6.1]
  def change
    add_column :ads, :eld_id, :text
  end
end
