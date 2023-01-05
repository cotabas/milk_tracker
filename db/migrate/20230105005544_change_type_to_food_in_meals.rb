class ChangeTypeToFoodInMeals < ActiveRecord::Migration[7.0]
  def change
    remove_column :meals, :type, :integer
    add_column :meals, :food, :integer, default: 0
  end
end
