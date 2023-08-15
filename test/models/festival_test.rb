# == Schema Information
#
# Table name: festivals
#
#  id                :bigint           not null, primary key
#  name              :string           not null
#  year              :integer          not null
#  state             :boolean          default(TRUE)
#  application_state :boolean          default(TRUE)
#  user_id           :bigint           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  description       :text
#  country           :string
#
require "test_helper"

class FestivalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
