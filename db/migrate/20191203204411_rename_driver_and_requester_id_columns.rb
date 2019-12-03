class RenameDriverAndRequesterIdColumns < ActiveRecord::Migration[6.0]
  def change
    rename_column :rides, :requester_id_id, :requester_id
    rename_column :rides, :driver_id_id, :driver_id
  end
end
