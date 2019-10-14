class AddProteinCarbsFatPercentageToNutriInfos < ActiveRecord::Migration[5.0]
  def change
    add_column :nutri_infos, :protein_percentage, :integer
    add_column :nutri_infos, :carbs_percentage, :integer
    add_column :nutri_infos, :fat_percentage, :integer
  end
end
