# == Schema Information
#
# Table name: ratings
#
#  id         :bigint           not null, primary key
#  stars      :integer
#  apply_id   :bigint           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Rating < ApplicationRecord
  # Validaciones 
  validates :stars , presence: true
  validates :user_id, presence: true
  validates :apply_id, uniqueness: { scope: :user_id, message: "Ya has calificado esta postulación" }

  # Realciones 
  belongs_to :apply
  belongs_to :user

end
