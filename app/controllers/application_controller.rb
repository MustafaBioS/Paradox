class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :dev_login
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :current_user

  private

  def dev_login
    return unless Rails.env.development?

    user = User.first_or_create!(
      name: "Dev User",
      email: "dev@local.test"
    )

    session[:user_id] = user.id
  end

  def current_user
    return @current_user if defined?(@current_user)

    @current_user = User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

  def require_login
    return if current_user

    redirect_to root_path(error: "login_required")
  end
end
