class AddAdToAds < ActiveRecord::Migration[6.1]
  def change
    add_column :ads, :ad_data, :string
  end
end
