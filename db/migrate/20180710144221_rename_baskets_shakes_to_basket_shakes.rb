class RenameBasketsShakesToBasketShakes < ActiveRecord::Migration[5.0]
  def change
    rename_table :baskets_shakes, :basket_shakes
  end
end
