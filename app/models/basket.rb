class Basket < ApplicationRecord
  belongs_to :customer
  has_many :basket_smoothies
  has_many :smoothies, through: :basket_smoothies

  validates_uniqueness_of :customer_id

  SUBSCRIPTION_FEE = {
    standard: 2900,
    tailored: 4900
  }

  def add_smoothies(smoothie_hash)
    smoothie_hash.each do |key, value|
      value.to_i.times do
        BasketSmoothie.create!(smoothie_id: key.to_i, basket_id: id)
      end
    end
  end

  def full?
    smoothies.count == 5
  end

  def active?
    status == 'active'
  end

  def cancelled?
    status == 'cancelled'
  end
end
