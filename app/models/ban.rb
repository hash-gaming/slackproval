class Ban < ApplicationRecord
  validates :ban_value, presence: true, uniqueness: true
  validates :ban_type, presence: true, inclusion: { in: ['ip', 'email', 'domain'] }
end
