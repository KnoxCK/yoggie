class SmoothieIngredient < ApplicationRecord
  belongs_to :smoothie
  belongs_to :ingredient
end
