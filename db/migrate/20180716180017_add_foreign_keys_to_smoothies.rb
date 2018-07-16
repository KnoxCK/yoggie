class AddForeignKeysToSmoothies < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :smoothies, :groups, index: true
    add_foreign_key :smoothies, :sizes, index: true
  end
end
