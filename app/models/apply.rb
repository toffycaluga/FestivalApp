class Apply < ApplicationRecord
  belongs_to :festival
  belongs_to :user
  belongs_to :category

  # Relaciones a active storage
  has_one_attached :apply_image
end
