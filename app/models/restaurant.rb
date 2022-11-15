class Restaurant < ApplicationController
  has_one :address, as: :addressable, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :customers, -> { distinct }, through: :reservations, source: :customer

  validates :name, presence: true
  validates :name, format: { with: GamingRestaurant::REGEX_NAME }, allow_blank: true
  validates_associated :address
end

# schema - 
# name, (optional: owner_id, area_covered, opened_from, opened_to)
