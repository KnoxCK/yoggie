class Address < ApplicationRecord
  belongs_to :customer

  DELIVERY_AREAS = ['SW17']
end
