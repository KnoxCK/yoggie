class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :customer

  validates_acceptance_of :accepted_terms, accept: true, on: :create

  def check_postcode(postcode)
    if ['SW17'].include?(postcode)
      update(postcode: postcode, valid_postcode: true)
    else
      update(postcode: postcode, valid_postcode: false)
    end
  end
end
