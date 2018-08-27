class CreateSmoothieIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :smoothie_ingredients do |t|
      t.references :smoothie, foreign_key: true
      t.references :ingredient, foreign_key: true
      t.boolean :large
      t.boolean :special

      t.timestamps
    end
  end
end
