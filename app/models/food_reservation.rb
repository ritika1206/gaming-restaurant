class FoodReservation < ApplicationRecord
  belongs_to :food, counter_cache: :foods_count
  belongs_to :reservation, counter_cache: :reservations_count

  validates :order_price, presence: true
  validates :order_price, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
end

# food_id, reservation_id, order_price
