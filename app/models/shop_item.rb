class ShopItem < ApplicationRecord
  has_many :orders
  has_many :users, through: :orders
  has_one_attached :image
end
