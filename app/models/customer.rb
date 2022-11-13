class Customer < ApplicationController
  REGEX_EMAIL = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/
  REGEX_CONTACT_NUMBER = /\d{10}/

  has_one :address, as: :addressable, dependent: :destroy
  has_one :reservation, dependent: :destroy
  has_many :tables, through: :reservation
  has_many :foods, through: :reservation
  has_many :games, through: :reservation

  validates :name, :email, :contact_number, presence: true
  with_options allow_blank: true do
    validates :name, format: { with: GamingRestaurant::REGEX_NAME }
    validates :email, format: { with: REGEX_EMAIL }
    validates :contact_number, format: { with: REGEX_CONTACT_NUMBER }
  end
  validates_associated :address
end

# schema - 
# name, email, contact_number
