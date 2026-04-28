class User < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :orders
  has_many :shop_items, through: :orders
end
