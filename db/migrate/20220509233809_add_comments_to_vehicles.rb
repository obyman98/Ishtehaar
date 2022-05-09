class AddCommentsToVehicles < ActiveRecord::Migration[6.1]
  def change
    add_column :vehicles, :comment, :text
  end
end
