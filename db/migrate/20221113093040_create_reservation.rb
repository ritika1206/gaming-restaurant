class CreateReservation < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.integer :table_number
      t.integer :foods_count
      t.integer :games_count
      t.integer :tables_count
      t.integer :people_count
      t.references :restaurant, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.integer :booking_amount
      t.integer :billing_amount
      t.string :booking_amount_status
      t.string :billing_amount_status
      t.string :status
      t.time :from
      t.time :to

      t.timestamps
    end
  end
end
