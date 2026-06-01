# class ReferController < ApplicationController
#   before_action :require_login, only: :index
#
#   def index
#     ensure_referral_code
#     @referral_url = "#{request.base_url}#{referral_path}?code=#{current_user.referral_code}"
#   end
#
#   def capture
#     code = params[:code].to_s.strip
#     referrer = User.find_by(referral_code: code) if code.present?
#
#     if referrer
#       session[:referral_code] = code
#       session[:referred_by_name] = referrer.username.presence || referrer.name.presence || "Someone"
#     else
#       session.delete(:referral_code)
#       session.delete(:referred_by_name)
#     end
#
#     redirect_to root_path
#   end
#
#   private
#
#   def ensure_referral_code
#     return if current_user.referral_code.present?
#
#     current_user.update!(referral_code: User.generate_referral_code)
#   end
# end
