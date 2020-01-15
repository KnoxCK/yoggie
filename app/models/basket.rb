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

  def next_delivery_date_string(year: true)
    date = Date.today
    date += 1 + ((1-date.wday) % 7)

    if year
      return "#{date.day.ordinalize} #{date.strftime("%B, %Y")}"
    else
      return date.strftime("%A %e %B")
    end
  end

  def two_days_before_delivery_date_string(year: true)
    date = Date.today
    date += 1 + ((1-date.wday) % 7)
    date = date - 2.days

    if year
      return "#{date.day.ordinalize} #{date.strftime("%B, %Y")}"
    else
      return date.strftime("%A %e %B")
    end
  end
end
