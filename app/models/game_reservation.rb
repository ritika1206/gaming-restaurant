class GameReservation < ApplicationRecord
  belongs_to :game, counter_cache: :games_count
  belongs_to :reservation, counter_cache: :reservations_count
end

# game_id, reservation_id
