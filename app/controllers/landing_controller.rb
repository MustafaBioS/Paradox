class LandingController < ApplicationController
  def index
    return unless current_user
    redirect_to home_path
  end
end
