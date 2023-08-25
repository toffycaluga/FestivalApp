# == Schema Information
#
# Table name: applies
#
#  id                            :bigint           not null, primary key
#  name                          :string
#  act                           :string
#  description                   :text
#  video_url                     :string
#  festival_id                   :bigint           not null
#  user_id                       :bigint           not null
#  category_id                   :bigint           not null
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  terms_and_conditions_accepted :boolean          default(FALSE)
#
require "test_helper"

class ApplyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
