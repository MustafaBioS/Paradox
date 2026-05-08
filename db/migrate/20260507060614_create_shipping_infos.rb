class CreateShippingInfos < ActiveRecord::Migration[8.1]
  def change
    create_table :shipping_infos do |t|

      t.references :user, null: false, foreign_key: true, index: { unique: true }

      t.string :first_name
      t.string :last_name
      t.string :email
      t.date :birthdate
      t.string :address_line_1
      t.string :address_line_2
      t.string :country
      t.string :city
      t.string :state
      t.string :postal_code

      t.timestamps
    end
  end
end
