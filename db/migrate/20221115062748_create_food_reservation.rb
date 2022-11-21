class CreateFoodReservation < ActiveRecord::Migration[7.0]
  def change
    create_table :food_reservations do |t|
      t.references :food, null: false, foreign_key: true
      t.references :reservation, null: false, foreign_key: true
      t.integer :paid_unit_price
      t.integer :quantity

      t.timestamps
    end
  end
end
