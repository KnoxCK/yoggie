class MoveFieldsFromCustomerToUser < ActiveRecord::Migration[5.0]
  def change
    remove_columns :customers, :newsletter, :accepted_terms, :email
    add_column :users, :newsletter, :boolean
    add_column :users, :accepted_terms, :boolean
  end
end
