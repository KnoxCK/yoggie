class AddStandardToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :standard, :boolean, default: false
  end
end
