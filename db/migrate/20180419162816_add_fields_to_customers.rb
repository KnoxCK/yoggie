class AddFieldsToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :bmr, :integer
    add_column :customers, :tdee, :integer
    add_column :customers, :daily_calorie_goal, :integer
    add_column :customers, :calories_per_shake, :integer
    add_column :customers, :protein, :integer
    add_column :customers, :fat, :integer
    add_column :customers, :carbs, :integer
  end
end
