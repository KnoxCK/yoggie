class RenameTables < ActiveRecord::Migration[5.0]
  def change
    rename_table :shakes, :smoothies
    rename_table :basket_shakes, :basket_smoothies
    remove_column      :basket_smoothies, :shake_id
    add_reference    :basket_smoothies, :smoothies, foreign_key: true
    add_foreign_key    :basket_smoothies, :baskets
  end
end
