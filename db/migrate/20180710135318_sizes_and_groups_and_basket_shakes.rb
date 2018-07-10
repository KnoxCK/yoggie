class SizesAndGroupsAndBasketShakes < ActiveRecord::Migration[5.0]
  def change
    create_table :sizes do |t|
      t.string :name
      t.integer :kcal
    end

    create_table :groups do |t|
      t.string :name
      t.integer :protein
    end

    create_join_table :shakes, :baskets

    remove_column :baskets, :shake_id
    remove_column :shakes, :size
    remove_column :shakes, :group
    remove_column :shakes, :price

    add_column :shakes, :size_id, :integer, foreign_key: true
    add_column :shakes, :group_id, :integer, foreign_key: true
    add_column :shakes, :image, :string
    add_column :shakes, :logo, :string
    add_column :shakes, :great_with, :text
    add_column :shakes, :ingredient_description, :text
    add_column :shakes, :story, :text
    add_column :shakes, :when, :text
    add_column :shakes, :benefits_one, :text
    add_column :shakes, :benefits_two, :text
    add_column :shakes, :benefits_three, :text
  end
end
