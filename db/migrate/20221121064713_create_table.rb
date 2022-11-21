class CreateTable < ActiveRecord::Migration[7.0]
  def change
    create_table :tables do |t|
      t.references :reservation, foreign_key: true
      t.string :status
      t.integer :capacity

      t.timestamps
    end
  end
end
