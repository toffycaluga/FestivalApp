# == Schema Information
#
# Table name: admin_festival_organizers
#
#  id          :bigint           not null, primary key
#  festival_id :bigint           not null
#  user_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Admin::FestivalOrganizer < ApplicationRecord
  belongs_to :festival
  belongs_to :user
end
