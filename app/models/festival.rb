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
class Festival < ApplicationRecord
  # validaciones
  validates :name, presence: true
  validates :year, presence: true  
  validates :description, presence: true
  validates :country, presence: true
  
  #  Relaciones 
  belongs_to :user

  #Relaciones a muchos
  has_many :applies, dependent: :destroy
  
  # Relaciones a active storage
  has_one_attached :festival_logo
end
