class Game < ApplicationController
  belongs_to :reservation, counter_cache: true

  validates :name, presence: true
  validates :name, format: { with: GamingRestaurant::REGEX_NAME }, allow_blank: true
end

# schema - 
# name, reservation_id

# future work - 
# name can be declared as enum
