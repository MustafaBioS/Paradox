class User < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :orders
  has_many :shop_items, through: :orders
  has_one :shipping_info, dependent: :destroy

  belongs_to :referred_by, class_name: "User", optional: true, counter_cache: :referrals_count
  has_many :referrals, class_name: "User", foreign_key: :referred_by_id, dependent: :nullify

  validates :referral_code, presence: true, uniqueness: true

  before_validation :ensure_referral_code, on: :create

  def self.generate_referral_code
    loop do
      code = SecureRandom.alphanumeric(8)
      return code unless User.exists?(referral_code: code)
    end
  end

  private

  def ensure_referral_code
    self.referral_code ||= self.class.generate_referral_code
  end
end
