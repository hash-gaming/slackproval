# == Schema Information
#
# Table name: requests
#
#  id               :bigint           not null, primary key
#  email            :string
#  reason           :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  status           :string           default("pending")
#  deleted_at       :datetime
#  ip               :string
#  code_of_conduct  :boolean          default(FALSE)
#  age_must_be_over :boolean          default(FALSE)
#

require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
