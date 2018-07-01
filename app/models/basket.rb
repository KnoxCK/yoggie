class Basket < ApplicationRecord
  belongs_to :customer
  has_many :shakes
end
