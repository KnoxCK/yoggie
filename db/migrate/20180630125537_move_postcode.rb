class MovePostcode < ActiveRecord::Migration[5.0]
  def change
    remove_column :customers, :postcode
    add_column :users, :postcode, :string
  end
end
