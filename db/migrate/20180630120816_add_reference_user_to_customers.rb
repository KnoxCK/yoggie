class AddReferenceUserToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_reference :customers, :user, foreign_key: true, index: true
  end
end
