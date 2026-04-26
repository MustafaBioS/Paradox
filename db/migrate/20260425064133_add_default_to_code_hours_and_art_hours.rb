class AddDefaultToCodeHoursAndArtHours < ActiveRecord::Migration[8.1]
  def change
    change_column_default :projects, :code_hours, from: nil, to: 0.0
    change_column_default :projects, :art_hours, from: nil, to: 0.0
    Project.where(code_hours: nil).update_all(code_hours: 0.0)
    Project.where(art_hours: nil).update_all(art_hours: 0.0)
  end
end
