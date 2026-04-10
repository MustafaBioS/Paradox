class HomeController < ApplicationController
  before_action :require_login
  def index
    @messages = [
      "Bomboclat Message #1",
      "Bomboclat Message #2",
      "Bomboclat Message #3",
      "Bomboclat Message #4",
      "Bomboclat Message #5",
      "Bomboclat Message #6",
      "Bomboclat Message #7",
      "Bomboclat Message #8",
      "Bomboclat Message #9",
      "Bomboclat Message #10",
      "Bomboclat Message #11",
      "Bomboclat Message #12",
      "Bomboclat Message #13",
      "Bomboclat Message #14",
      "Bomboclat Message #15",
    ]
  end
end
