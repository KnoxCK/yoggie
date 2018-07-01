class AddValidPostcodeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :valid_postcode, :boolean
  end
end
