class ChangeInternationalDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :international, nil
  end
end
