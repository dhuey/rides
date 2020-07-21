class EditUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:users, :first_name, true)
    change_column_null(:users, :last_name, true)
    change_column_null(:users, :nationality, true)
    change_column_null(:users, :phone_number, true)
    change_column_null(:users, :gender, true)
  end
end
