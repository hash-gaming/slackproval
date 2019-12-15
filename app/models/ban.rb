# == Schema Information
#
# Table name: bans
#
#  id         :bigint           not null, primary key
#  ban_type   :string
#  ban_value  :string
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Ban < ApplicationRecord
  audited only: [:ban_value, :ban_type, :deleted_at]
  acts_as_paranoid

  validates :ban_value, presence: true, uniqueness: true
  validates :ban_type, presence: true, inclusion: { in: ['ip', 'email', 'domain'] }
  validate :proper_format_for_ban_type


  def self.check(email, ip)
    if Ban.where(ban_type: 'domain', ban_value: email.split("@").last).present? ||
       Ban.where(ban_type: 'email', ban_value: email).present? ||
       Ban.where(ban_type: 'ip', ban_value: ip).present?
      true
    else
      false
    end
  end

  private
  def proper_format_for_ban_type
    case ban_type
    when 'email'
      unless !!(ban_value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/)
        errors.add(:ban_value, " invalid email")
      end
    when 'domain'
      unless !!(ban_value =~ /^(?!:\/\/)([a-zA-Z0-9]+\.)?[a-zA-Z0-9][a-zA-Z0-9-]+\.[a-zA-Z]{2,6}?$/)
        errors.add(:ban_value, " invalid domain")
      end
    when 'ip'
      unless !!(ban_value =~ /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/)
        errors.add(:ban_value, " invalid IP")
      end
    end
  end
end
