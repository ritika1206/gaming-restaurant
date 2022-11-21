class Reservation < ApplicationController
  MIN_AMOUNT = 0
  MAX_TABLE_CAPACITY = 100

  belongs_to :restaurant, counter_cache: true
  belongs_to :customer
  has_many :game_reservations, dependent: :destroy, counter_cache: :games_count
  has_many :games, through: :game_reservations, source: :game
  has_many :food_reservations, dependent: :destroy, counter_cache: :foods_count
  has_many :foods, through: :food_reservations, source: :food
  has_many :tables, dependent: :nullify

  validates :from, :booking_amount_status, :billing_amount_status, :status, :people_count, presence: true
  with_options allow_blank: true do
    validates :billing_amount, comparison: { greater_than: :booking_amount }
    validates :to, comparison: { greater_than: :from }
    validates :billing_amount, :booking_amount, :people_count, numericality: { only_integer: true, greater_than: MIN_AMOUNT }, allow_blank: true
  end

  before_create :set_tables
  after_create_commit :send_reservation_confirmation_email

  enum booking_amount_status: [:paid, :unpaid, :refunded]
  enum billing_amount_status: [:paid, :unpaid, :refunded]
  enum status: [:booked, :cancelled, :expired, :not_booked]

  private

    def send_reservation_confirmation_email
      ReservationMailer.confirm_reservation(self).deliver_later
    end

    def set_tables
      require_people_count = people_count

      loop do
        best_fit_table = nil
        min = MAX_TABLE_CAPACITY

        Table.free.each do |table|
          capacity_difference = table.capacity - require_people_count
          if min >= capacity_difference.abs
            best_fit_table = table
            min = capacity_difference.abs
          end
        end

        self.tables << best_fit_table

        if capacity_difference.positive?
          break
        else
          require_people_count = capacity_difference.abs
        end
      end
    end
end

# schema - 
# restaurant_id, customer_id, foods_count, games_count, tables_count, people_count, from(datetime), to(datetime), booking_amount, billing_amount, booking_amount_status, billig_amount_status, status

# future work - 
# state machine can be used for managing statuses
