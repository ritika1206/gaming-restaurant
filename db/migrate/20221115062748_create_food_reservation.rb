class CreateFoodReservation < ActiveRecord::Migration[7.0]
  def change
    create_table :food_reservations do |t|
      t.references :food, null: false, foreign_key: true
      t.references :reservation, null: false, foreign_key: true
      t.integer :order_price

      t.timestamps
    end
  end
end
