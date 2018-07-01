class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :address_line_one
      t.references :customer, foreign_key: true
      t.string :address_line_two
      t.string :address_line_three
      t.string :postcode
      t.text :delivery_instructions

      t.timestamps
    end
  end
end
