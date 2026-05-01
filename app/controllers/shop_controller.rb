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

  def confirm
    redirect_to shop_path and return unless params[:shop_item_id].present?
    @selected_item = ShopItem.find_by(id: params[:shop_item_id])
    redirect_to shop_path and return unless @selected_item
    redirect_to shop_path, alert: "Not enough hours." and return if @selected_item.hours > current_user.shipped_hours
    @quantity = params[:quantity].to_i
    redirect_to confirm_path(shop_item_id: @selected_item, quantity: 1) and return unless @quantity > 0
  end

  def create
    item = ShopItem.find(params[:shop_item_id])
    quantity = 2

    current_user.with_lock do
      current_user.orders.create!(
        shop_item: item,
        quantity: quantity,
        status: "pending",
        total: item.hours * quantity
      )
      new_hours = current_user.shipped_hours - (item.hours * quantity)
      current_user.update!(shipped_hours: new_hours)
    end

    redirect_to shop_path, notice: "Order placed!"
  end

  def orders
    @orders = current_user.orders
  end

end