class AddUnshippedHours < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :unshipped_hours, :decimal, :precision => 8, :scale => 2
  end
end
