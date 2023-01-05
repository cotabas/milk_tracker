class CreateMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :meals do |t|
      t.integer :quantity
      t.integer :type, default: 0

      t.timestamps
    end
  end
end
