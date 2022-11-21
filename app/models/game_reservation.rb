class GameReservation < ApplicationRecord
  belongs_to :game, counter_cache: :games_count
  belongs_to :reservation, counter_cache: :reservations_count

  validates :paid_unit_price, :quantity, presence: true
  validates :paid_unit_price, :quantity, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
end

# game_id, reservation_id, paid_unit_price, quantity
