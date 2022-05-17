class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :state
      t.string :city
      t.string :ntn
      t.integer :poc

      t.timestamps
    end

    add_reference :companies, :user, null: false, foreign_key: true
  end
end
