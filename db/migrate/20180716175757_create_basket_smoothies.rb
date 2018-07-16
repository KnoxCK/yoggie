class CreateBasketSmoothies < ActiveRecord::Migration[5.0]
  def change
    create_table :basket_smoothies do |t|
      t.references :basket, foreign_key: true
      t.references :smoothie, foreign_key: true

      t.timestamps
    end
  end
end
