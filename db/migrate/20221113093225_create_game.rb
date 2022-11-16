class CreateGame < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :name
      t.integer :available_set
      t.integer :price
      
      t.timestamps
    end
  end
end
