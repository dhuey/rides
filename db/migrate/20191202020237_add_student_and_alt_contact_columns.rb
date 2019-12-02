class AddStudentAndAltContactColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :international, :boolean, default: false
    add_column :users, :alternate_contact_method, :string
    add_column :users, :alternate_contact_name, :string
  end
end
