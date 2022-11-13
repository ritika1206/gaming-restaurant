class Food < ApplicationController
  belongs_to :reservation, counter_cache: true

  validates :name, presence: true
  validates :name, format: { with: GamingRestaurant::REGEX_NAME }, allow_blank: true
end

# schema - 
# name, (optional: calories, protiens, cabs, weight), reservation_id

# future work -
# can declare name as enum (as a restaurant can have a set of food items available)
