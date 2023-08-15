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
#  role                   :string           default("Usuario")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  superadmin             :boolean          default(FALSE)
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
  has_one_attached :avatar

  #Relacionnes a muchos 
  has_many :festivals, dependent: :destroy
  has_many :applies , dependent: :destroy
  has_many :organizerships
  has_many :organized_festivals, through: :organizerships, source: :festival

  has_many :admin_festival_organizers
  has_many :organized_festivals, through: :admin_festival_organizers, source: :festival



end
