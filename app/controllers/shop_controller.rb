class ShopController < ApplicationController
  before_action :require_login

  def index
    @ticket_item = ShopItem.find_by(name: "Ticket to Fable")
    @shop_items = ShopItem.where.not(id: @ticket_item&.id)

    @selected_item = nil

    if params[:shop_item_id].present?
      @selected_item = ShopItem.find_by(id: params[:shop_item_id])

      redirect_to shop_path and return unless @selected_item
    end
  end

  def order
    item = ShopItem.find(params[:shop_item_id])

    current_user.orders.create!(
      shop_item: item,
      quantity: 1,
      status: "pending"
    )
  end
end