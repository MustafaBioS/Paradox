class AddHackatimeTokenToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :hackatime_token, :string
  end
end
