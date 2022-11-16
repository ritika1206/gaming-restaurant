class Food < ApplicationController
  has_many :food_reservation, counter_cache: :foods_count
  has_many :reservations, -> { distinct }, through: :food_reservation, source: :reservation

  validates :name, :available_stock, :price, presence: true
  with_options allow_blank: true do
    validates :name, format: { with: GamingRestaurant::REGEX_NAME }
    validates :available_stock, :price, numericality: { only_integer: true, greater_than: 0 }
  end

end

# schema - 
# name, (optional: calories, protiens, cabs, weight), available_stock, price

# future work -
# can declare name as enum (as a restaurant can have a set of food items available)
# only display those foods having available_stock >= 1. Ajax polling to dynamic update the availability of foods based on available_stock
