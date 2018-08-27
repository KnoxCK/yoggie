class CreateNutriInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :nutri_infos do |t|
      t.references :smoothie, foreign_key: true
      t.float :energy_kJ
      t.float :energy_kcal
      t.float :fat_g
      t.float :fat_saturates_g
      t.float :carbs_g
      t.float :carbs_sugars_g
      t.float :fibre_g
      t.float :protein_g
      t.float :salt_g

      t.timestamps
    end
  end
end
