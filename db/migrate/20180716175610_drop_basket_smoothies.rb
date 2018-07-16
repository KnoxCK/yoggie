class DropBasketSmoothies < ActiveRecord::Migration[5.0]
  def change
    drop_table :basket_smoothies
  end
end
