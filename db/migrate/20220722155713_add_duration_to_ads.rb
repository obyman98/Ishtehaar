class AddDurationToAds < ActiveRecord::Migration[6.1]
  def change
    add_column :ads, :duration, :integer
  end
end
