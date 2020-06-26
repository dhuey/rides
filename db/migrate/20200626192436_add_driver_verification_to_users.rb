class AddDriverVerificationToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :driver_verified, :boolean, default: false
  end
end
