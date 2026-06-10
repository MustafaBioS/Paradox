class MakeHoursSafe < ActiveRecord::Migration[8.1]
  def change
    change_column_default :users, :unshipped_hours, 0

    User.where(unshipped_hours: nil).update_all(unshipped_hours: 0)

    change_column_null :users, :unshipped_hours, false
    change_column_null :users, :shipped_hours, false
  end
end
