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
class Apply < ApplicationRecord
   
  validates :name, presence: true
  validates :act, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :terms_and_conditions_accepted, acceptance: { accept: true }
  
  
  # youtube_embed :video_url, {:with_description => true, :width => 450, :height => 300}
  #  Relaciones
  belongs_to :festival
  belongs_to :user
  belongs_to :category

  # Relaciones a active storage
  has_one_attached :apply_image
end
