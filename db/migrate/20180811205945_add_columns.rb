class AddColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :stripe_id, :string
    add_column :baskets, :status, :string, default: 'pending'
  end
end
