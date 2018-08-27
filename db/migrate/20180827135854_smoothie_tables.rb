class SmoothieTables < ActiveRecord::Migration[5.0]
  def change
    add_column :smoothies, :description, :text
    add_column :smoothies, :number, :integer
    add_column :smoothies, :contains, :text
    add_column :smoothies, :superfood, :string
  end
end
