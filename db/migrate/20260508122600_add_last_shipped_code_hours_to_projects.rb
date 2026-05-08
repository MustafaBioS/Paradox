class AddLastShippedCodeHoursToProjects < ActiveRecord::Migration[8.1]
  def change
    add_column :projects, :last_shipped_code_hours, :decimal, default: 0.0, null: false
  end
end

