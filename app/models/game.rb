class Game < ApplicationController
  has_many :game_reservation, counter_cache: :games_count
  has_many :reservations, -> { distinct }, through: :game_reservation, source: :reservation

  validates :name, :available_set, :price, presence: true
  with_options allow_blank: true do
    validates :name, format: { with: GamingRestaurant::REGEX_NAME }
    validates :available_set, :price, numericality: { only_integer: true, greater_than: 0 }
  end    
end

# schema - 
# name, available_set, price

# future work - 
# name can be declared as enum
# only display those games having available_set >= 1. Ajax polling to dynamic update the availability of games based on available_set
