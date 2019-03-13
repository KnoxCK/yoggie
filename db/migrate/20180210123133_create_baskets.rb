class CreateBaskets < ActiveRecord::Migration[5.0]
  def change
    create_table :baskets do |t|
      t.references :customer, foreign_key: true
      t.references :shake, foreign_key: true
      t.boolean :tailored, default: true
      t.timestamps
    end
  end
end
