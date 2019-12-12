class AddEmailInterest < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :email_interest, :boolean, null: false, default: true
  end
end
