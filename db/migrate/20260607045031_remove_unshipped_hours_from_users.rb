class RemoveUnshippedHoursFromUsers < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :unshipped_hours
  end
end
