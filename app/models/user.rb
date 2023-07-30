# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  name                   :string
#  phone_number           :string
#  role                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  #CanCanCan
  ROLES = %w[Admin Jurado Usuario Organizador].freeze

  #Validaciones 
  validates :name, presence: true
  validates :phone_number, presence: true

  # Relaciones a active storage
  has_one_attached :profile_photo

  # Redimensionar la imagen antes de guardarla
  after_commit :resize_profile_photo, on: :create

  private

  def resize
    return unless profile_photo.attached?

    # Redimensionar si el ancho es mayor que 800 píxeles
    if profile_photo.blob.width > 800
      profile_photo.variant(resize_to_limit: [800, nil]).processed
    end
  end
  

end
