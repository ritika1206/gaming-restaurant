class Table < ApplicationRecord
  MIN_NUMBER
  belongs_to :restaurant, counter_cache: true, optional: true
  belongs_to :reservation, counter_cache: true, optional: true

  validates :number, presence: true
  validates :number, numericality: { only_integer: true, greater_than: MIN_NUMBER }, allow_blank: true
end

# schema - 
# number, restaurant_id, reservation_id, (optional: length, width, brand, material)
