class Reservation < ApplicationController
  MIN_AMOUNT = 0

  belongs_to :restaurant, counter_cache: true
  belongs_to :customer
  has_many :tables, counter_cache: :tables_count, dependent: :nullify
  has_many :games, counter_cache: :games_count, dependent: :destroy
  has_many :foods, counter_cache: :foods_count, dependent: :destroy

  validates :from, :booking_amount_status, :billing_amount_status, :status, presence: true
  with_options allow_blank: true do
    validates :billing_amount, comparison: { greater_than: :booking_amount }
    validates :to, comparison: { greater_than: :from }
    validates :billing_amount, :booking_amount, numericality: { only_integer: true, greater_than: MIN_AMOUNT }, allow_blank: true
  end

  after_create_commit :send_reservation_confirmation_email

  enum booking_amount_status: [:paid, :unpaid, :refunded]
  enum billing_amount_status: [:paid, :unpaid, :refunded]
  enum status: [:booked, :cancelled, :expired, :not_booked]

  private

    def send_reservation_confirmation_email
      ReservationMailer.confirm_reservation(self).deliver_later
    end
end

# schema - 
# restaurant_id, customer_id, foods_count, games_count, from(datetime), to(datetime), booking_amount, billing_amount, booking_amount_status, billig_amount_status, status

# future work - 
# state machine can be used for managing statuses
