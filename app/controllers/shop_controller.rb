class ShopController < ApplicationController
  before_action :require_login
  def index
    @shop_items = ShopItem.all
  end
end
