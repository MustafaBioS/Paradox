class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :username
      t.string :slack_id
      t.string :verification_status

      t.timestamps
    end
  end
end
