class AddModifyAdIdToEvents < ActiveRecord::Migration[6.1]
  def change
    change_column :events, :ad_id, :integer, :null => true
  end
end
