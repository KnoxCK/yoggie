class RenameReferencesBasketSmoothies < ActiveRecord::Migration[5.0]
  def change
    remove_column :basket_smoothies, :smoothies_id
    remove_column :basket_smoothies, :basket_id
    add_column :basket_smoothies, :smoothie_id, :integer, foreign_key: true, index: true
    add_column :basket_smoothies, :basket_id, :integer, foreign_key: true, index: true
  end
end
