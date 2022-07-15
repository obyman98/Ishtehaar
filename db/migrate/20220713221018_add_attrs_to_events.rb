class AddAttrsToEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :ad_count
    add_column :events, :count, :integer
    add_column :events, :location, :string
    add_column :events, :duration, :integer
    add_column :events, :bulk_data, :json
    add_column :events, :event_type, :string
  end
end
