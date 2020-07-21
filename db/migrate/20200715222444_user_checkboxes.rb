class UserCheckboxes < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :accept_tac, :boolean
    add_column :users, :valid_driver, :boolean
  end
end
