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

require 'test_helper'

class BanTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
