class Basket < ApplicationRecord
  belongs_to :customer
  belongs_to :shake
end
