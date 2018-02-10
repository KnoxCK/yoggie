class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :basket, foreign_key: true
      t.float :amount

      t.timestamps
    end
  end
end
