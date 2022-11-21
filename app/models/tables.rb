class Table < ApplicationRecord
  belongs_to :reservation, counter_cache: true, optional: true

  validates :capacity, presence: true
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true

  enum status: [:free, :occupied]

  before_create :set_status

  private

    def set_status
      self.status = 'occupied' if reservation.present?
    end
end

# reservation_id, capacity, status(default = free)
