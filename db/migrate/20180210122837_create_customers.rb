class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.integer :age
      t.string :gender
      t.integer :weight
      t.integer :height
      t.string :activity_level
      t.string :goal
      t.boolean :newsletter, default: false
      t.string :postcode

      t.timestamps
    end
  end
end
