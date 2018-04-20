class AddTermsToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :accepted_terms, :boolean, default: false
  end
end
