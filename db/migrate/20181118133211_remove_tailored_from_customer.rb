class RemoveTailoredFromCustomer < ActiveRecord::Migration[5.0]
  def change
    remove_column :customers, :tailored
  end
end
