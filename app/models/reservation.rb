class Reservation < ApplicationController
  MIN_AMOUNT = 0

  belongs_to :restaurant, counter_cache: true
  belongs_to :customer
  has_many :game_reservations, dependent: :destroy, counter_cache: :games_count
  has_many :games, through: :game_reservations, source: :game
  has_many :food_reservations, dependent: :destroy, counter_cache: :foods_count
  has_many :foods, through: :food_reservations, source: :food

  validates :from, :booking_amount_status, :billing_amount_status, :status, :people_count, presence: true
  with_options allow_blank: true do
    validates :billing_amount, comparison: { greater_than: :booking_amount }
    validates :to, comparison: { greater_than: :from }
    validates :billing_amount, :booking_amount, :people_count, numericality: { only_integer: true, greater_than: MIN_AMOUNT }, allow_blank: true
  end

  before_create :set_tables_count
  after_create_commit :send_reservation_confirmation_email

  enum booking_amount_status: [:paid, :unpaid, :refunded]
  enum billing_amount_status: [:paid, :unpaid, :refunded]
  enum status: [:booked, :cancelled, :expired, :not_booked]

  private

    def send_reservation_confirmation_email
      ReservationMailer.confirm_reservation(self).deliver_later
    end

    def set_tables_count
      self.tables_count = (people_count/4.0).ceil
    end
end

# schema - 
# restaurant_id, customer_id, foods_count, games_count, tables_count, people_count, from(datetime), to(datetime), booking_amount, billing_amount, booking_amount_status, billig_amount_status, status

# future work - 
# state machine can be used for managing statuses
