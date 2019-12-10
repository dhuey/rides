class AddRequesterGender < ActiveRecord::Migration[6.0]
  def change
    add_column :rides, :requester_gender, :string, null: false
  end
end
