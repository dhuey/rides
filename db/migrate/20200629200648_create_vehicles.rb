class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles do |t|
      t.belongs_to :user, null: false
      t.string :year, null: false
      t.string :color, null: false
      t.string :make, null: false
      t.string :model, null: false
      t.string :license_plate, null: false
      t.timestamps
    end
  end
end
