class Basket < ApplicationRecord
  belongs_to :customer
  has_many :basket_smoothies
end
