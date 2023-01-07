class AddFedTimeToMeals < ActiveRecord::Migration[7.0]
  def change
    add_column :meals, :fed_time, :time 
  end
end
