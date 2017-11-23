class Request < ApplicationRecord
  audited only: :status
  acts_as_paranoid

  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validate :reason_required
  validates :status, inclusion: { in: ['pending', 'approved', 'denied', 'deleted'] }

  scope :approved, -> { where status: 'approved' }
  scope :denied, -> { where status: 'denied' }
  scope :new_items, -> { where status: 'pending' }


  def approved?
    status == 'approved'
  end

  def denied?
    status == 'denied'
  end

  def self.reason_required?
    ENV.fetch("REASON_REQUIRED", "true") == "true"
  end

  private
  def reason_required
    if Request.reason_required? && reason.blank?
      errors.add(:reason, "can't be blank")
    end
  end
end
