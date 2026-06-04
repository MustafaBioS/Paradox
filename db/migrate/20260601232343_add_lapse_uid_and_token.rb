class AddLapseUidAndToken < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :lapse_uid, :string
    add_column :users, :lapse_token, :string
  end
end
