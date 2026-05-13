class DevController < ApplicationController
  def login
    unless Rails.env.development?
      head :not_found
      return
    end

    email = params[:email].presence || "dev-#{SecureRandom.hex(4)}@local.test"
    name = params[:name].presence || "Dev User"

    user = User.find_or_create_by!(email: email) do |record|
      record.name = name
    end

    if user.previously_new_record?
      referral_code = session[:referral_code].to_s.strip
      referrer = User.find_by(referral_code: referral_code) if referral_code.present?
      user.update!(referred_by: referrer) if referrer && referrer.email != user.email
    end

    session.delete(:referral_code)
    session.delete(:referred_by_name)

    session[:user_id] = user.id
    redirect_to home_path
  end

  def logout
    unless Rails.env.development?
      head :not_found
      return
    end

    reset_session
    redirect_to root_path
  end
end
