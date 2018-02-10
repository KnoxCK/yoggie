class CreateShakes < ActiveRecord::Migration[5.0]
  def change
    create_table :shakes do |t|
      t.string :name
      t.string :group
      t.integer :size
      t.float :price

      t.timestamps
    end
  end
end
