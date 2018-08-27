class CreateIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.boolean :allergen
      t.boolean :special
      t.boolean :superfood
      t.text :contents
      t.string :image

      t.timestamps
    end
  end
end
