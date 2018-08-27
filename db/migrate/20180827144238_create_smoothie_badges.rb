class CreateSmoothieBadges < ActiveRecord::Migration[5.0]
  def change
    create_table :smoothie_badges do |t|
      t.references :smoothie, foreign_key: true
      t.references :badge, foreign_key: true

      t.timestamps
    end
  end
end
