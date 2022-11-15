class FoodReservation < ApplicationRecord
  belongs_to :food, counter_cache: :foods_count
  belongs_to :reservation, counter_cache: :reservations_count
end

# food_id, reservation_id
