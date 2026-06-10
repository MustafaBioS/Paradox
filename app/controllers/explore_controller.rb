class ExploreController < ApplicationController
  before_action :require_login
  def index
    @projects = Project.where(status: "shipped")
  end
end
