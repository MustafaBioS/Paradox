class AdminController < ApplicationController
  before_action :require_login
  before_action :require_admin

  def index
  end

  def users
    @users = User.all

    if params[:q].present?
      @users = @users.where("name ILIKE :q OR email ILIKE :q", q: "%#{params[:q]}%")
    end

    sort = params[:sort].presence_in(%w[name email created_at]) || "created_at"
    direction = params[:direction] == "asc" ? "asc" : "desc"

    @users = @users.order("#{sort} #{direction}")

    @users = @users.page(params[:page]).per(20)
  end

  def orders
  end

  def projects
  end

  def shop
  end

end
