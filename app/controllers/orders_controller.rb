class OrdersController < ApplicationController
  before_action :require_login

  def index
    @orders = current_user.orders
  end
  def create
    item = ShopItem.find(params[:shop_item_id])
    current_user.orders.create!(shop_item: item, quantity: 1, status: "pending")
    redirect_to shop_path, notice: "Order placed!"
  end
end
