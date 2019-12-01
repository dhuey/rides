class FillInUsersAndRides < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :nationality, :string, null: false
    add_column :users, :gender, :string, null: false
    add_column :users, :ministry, :string
    add_column :users, :phone_number, :bigint, null: false
    add_column :users, :ride_tokens, :integer, default: 4

    create_table :rides do |t|
      t.references :requester_id, foreign_key: { to_table: :users }, null: false
      t.datetime :requested_at, null: false
      t.string :origin, null: false
      t.string :destination, null: false
      t.datetime :pickup_time, null: false
      t.integer :number_of_passengers, null: false
      t.string :notes
      t.integer :distance
      t.boolean :claimed, default: 0
      t.references :driver_id, foreign_key: { to_table: :users }
      t.boolean :completed, default: 0
      t.timestamps
    end
  end
end
