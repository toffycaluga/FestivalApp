class Festival < ApplicationRecord
    
  belongs_to :user
    
  
  # Relaciones a active storage
  has_one_attached :festival_logo
end
