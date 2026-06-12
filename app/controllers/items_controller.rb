class ItemsController < ApplicationController
  before_action :require_login

  def item_params
    params.require(:shop_item).permit(:name, :hours, :description, :image)
  end
end
