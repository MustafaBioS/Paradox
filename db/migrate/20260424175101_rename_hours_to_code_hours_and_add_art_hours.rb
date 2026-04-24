class RenameHoursToCodeHoursAndAddArtHours < ActiveRecord::Migration[8.1]
  def change
    rename_column :projects, :hours, :code_hours
    add_column :projects, :art_hours, :decimal
  end
end
