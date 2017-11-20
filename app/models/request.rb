class Request < ApplicationRecord
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :reason, presence: true

  scope :approved, -> { where(approved: true) }
  scope :denied, -> { where(denied: true) }
  scope :new_items, -> { where(approved: nil, denied: nil) }

end
