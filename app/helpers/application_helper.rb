module ApplicationHelper
  def display_username(user)
    user.username.presence || user.name.to_s.split(/\s+/).first
  end
end
