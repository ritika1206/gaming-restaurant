class CreateAddress < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :city
      t.string :state
      t.integer :pincode
      t.references :addressable, null: false, polymorphic: true

      t.timestamps
    end
  end
end
