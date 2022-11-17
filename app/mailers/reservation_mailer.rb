class ReservationMailer < ApplicationMailer
  def confirm_reservation(reservation)
    @reservation = reservation.includes(:foods, :games)
    mail to: reservation.customer.email, subject: "Reservation Confirmation at #{reservation.restaurant}"
  end
end
