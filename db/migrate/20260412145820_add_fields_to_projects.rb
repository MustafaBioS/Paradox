class AddFieldsToProjects < ActiveRecord::Migration[8.1]
  def change
    add_column :projects, :repo_url, :string
    add_column :projects, :demo_url, :string
  end
end
