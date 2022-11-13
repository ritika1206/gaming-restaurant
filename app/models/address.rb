class Address < ApplicationRecord
  REGEX_PINCODE = /\d{5, 6}/
  
  belongs_to :addressable, polymorphic: true

  validates :country, :city, :state, :pincode, presence: true
  with_options allow_blank: true do
    validates :country, :city, :state, format: { with: GamingRestaurant::REGEX_NAME }
    validates :pincode, format: { with: REGEX_PINCODE }
  end
end

# schema - 
# country, city, state, pincode
