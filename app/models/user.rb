class User < ApplicationRecord
  require 'uk_postcode'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :customer

  validates_acceptance_of :accepted_terms, accept: true, on: :create

  def check_postcode(inputted_postcode)
    postcode = inputted_postcode.tr(' ', '').upcase
    byebug
    postcode_outcode = UKPostcode.parse(postcode).outcode
    if Address::DELIVERY_AREAS.include?(postcode_outcode)
      update(postcode: postcode, valid_postcode: true)
    else
      update(postcode: postcode, valid_postcode: false)
    end
  end
end
