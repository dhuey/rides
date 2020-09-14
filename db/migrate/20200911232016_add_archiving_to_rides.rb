class AddArchivingToRides < ActiveRecord::Migration[6.0]
  def change
    add_column :rides, :archived_at, :datetime, default: nil
  end
end
