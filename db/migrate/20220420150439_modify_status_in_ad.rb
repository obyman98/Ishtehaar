class ModifyStatusInAd < ActiveRecord::Migration[6.1]
  def change
    change_column :ads, :status, :text, default: 'pending'
  end
end
