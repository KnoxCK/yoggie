class AddSlugToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :slug, :string
  end
end
