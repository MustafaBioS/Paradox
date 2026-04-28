class ShopController < ApplicationController
  before_action :require_login
  def index
    @shop_items = ShopItem.all
    @selected_item = if params[:shop_item_id].present?
       @shop_items.find_by(id: params[:shop_item_id])
     else
       nil
     end
  end
  def order
    current_user.orders.create!(shop_item: item, quantity: 1, status: "pending")
  end
end
