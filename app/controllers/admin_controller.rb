class AdminController < ApplicationController
  before_action :require_login
  before_action :require_admin

  def index
  end

  def users
    @users = User.all
  end

  def orders
  end

  def projects
  end

  def shop
  end

end
