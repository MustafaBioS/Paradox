class CreateShopItems < ActiveRecord::Migration[8.1]
  def change
    create_table :shop_items do |t|
      t.string :name
      t.integer :hours
      t.text :description
      t.string :image

      t.timestamps
    end
  end
end
