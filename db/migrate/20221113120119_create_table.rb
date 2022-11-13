class CreateTable < ActiveRecord::Migration[7.0]
  def change
    create_table :tables do |t|
      t.string :number
      t.references :restaurant, foreign_key: true
      t.references :reservation, foreign_key: true

      t.timestamps
    end
  end
end
