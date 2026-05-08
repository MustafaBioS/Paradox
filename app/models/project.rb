class Project < ApplicationRecord
  SHIPPING_HOURS_REQUIRED = 5.0

  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true
  has_one_attached :thumbnail

  def ready_for_shipping?
    shipping_incomplete_reasons.empty?
  end

  def shipping_incomplete_reasons
    reasons = []
    reasons << "Please change the project title from \"project name\"." if title.blank? || title == "project name"
    reasons << "Please fill out the project description." if description.blank? || description == "No description yet"
    reasons << "Please upload a thumbnail before shipping." unless thumbnail.attached?

    required_hours = last_shipped_code_hours.to_f.positive? ? last_shipped_code_hours.to_f + SHIPPING_HOURS_REQUIRED : SHIPPING_HOURS_REQUIRED
    if code_hours.to_f < required_hours
      reasons << if last_shipped_code_hours.to_f.positive?
        "Please earn 5 additional Hackatime hours since your last ship."
      else
        "Please reach at least 5 Hackatime hours before shipping."
      end
    end

    reasons
  end

  def mark_as_shipped!
    update!(status: "pending_review", last_shipped_code_hours: code_hours)
  end
end
