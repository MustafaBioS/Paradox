class AddHoursToUser < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :shipped_hours, :integer
  end
end
