class Basket < ApplicationRecord
  belongs_to :customer
  has_many :basket_smoothies
  has_many :smoothies, through: :basket_smoothies

  def add_smoothies(smoothie_hash)
    smoothie_hash.each do |key, value|
      value.to_i.times do
        BasketSmoothie.create!(smoothie_id: key.to_i, basket_id: id)
      end
    end
  end
end
