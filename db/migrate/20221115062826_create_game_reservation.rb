class CreateGameReservation < ActiveRecord::Migration[7.0]
  def change
    create_table :game_reservations do |t|
      t.references :game, null: false, foreign_key: true
      t.references :reservation, null: false, foreign_key: true
      t.integer :order_price

      t.timestamps
    end
  end
end
