class DefaultDesc < ActiveRecord::Migration[8.1]
  def change
    change_column_default :projects, :description, "No description yet"
  end
end
