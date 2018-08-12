class Address < ApplicationRecord
  require 'uk_postcode'
  belongs_to :customer

  DELIVERY_AREAS = ['W9', 'W8', 'W6', 'W2', 'W1H', 'W14', 'W12', 'W11', 'SW8', 'SW9', 'SW8', 'SW7', 'SW3', 'SW4', 'SW5',
                    'SW6', 'SW2', 'SW17', 'SW18', 'SW19', 'SW15', 'SW12', 'SW11', 'SW10', 'NW8', 'NW1', 'SW1W', 'SW1X',
                    'SW1V', 'SW1P', 'SW1A', 'SW1H', 'SW1E']


  def check_postcode(inputted_postcode)
    postcode_outcode = UKPostcode.parse(inputted_postcode).outcode
    DELIVERY_AREAS.include?(postcode_outcode)
  end
end
