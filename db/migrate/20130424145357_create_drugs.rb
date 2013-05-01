class CreateDrugs < ActiveRecord::Migration
  def change
    create_table :drugs do |t|
      t.string :generic_name
      t.string :medical_name
      t.string :form
      t.string :conditions
      t.integer :thirty_day_price
      t.integer :thirty_day_quantity
      t.integer :ninety_day_price
      t.integer :ninety_day_quantity

      t.timestamps
    end
  end
end
