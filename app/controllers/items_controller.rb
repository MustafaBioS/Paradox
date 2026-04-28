class ItemsController < ApplicationController
  before_action :require_login

  params.require(:shop_item).permit(:name, :hours, :description, :image)
end
