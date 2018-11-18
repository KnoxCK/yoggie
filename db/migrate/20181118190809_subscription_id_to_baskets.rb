class SubscriptionIdToBaskets < ActiveRecord::Migration[5.0]
  def change
    add_column :baskets, :stripe_sub_id, :string
  end
end
