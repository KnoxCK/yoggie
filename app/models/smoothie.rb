class Smoothie < ApplicationRecord
  has_many :basket_smoothies
  belongs_to :group
  belongs_to :size

  def self.fetch_bundle(customer)
    protein = customer.protein
    kcal = customer.calories_per_shake
    where(group: fetch_group(protein), size: fetch_size(kcal))
  end

  def self.fetch_group(protein)
    return Group.find_by(name: 'A') if protein < Group.find_by(name: 'A').protein
    return Group.find_by(name: 'B') if protein < Group.find_by(name: 'B').protein
    Group.find_by(name: 'C')
  end

  def self.fetch_size(kcal)
    return Size.find_by(name: 'i') if kcal < (Size.find_by(name: 'i').kcal + 25)
    return Size.find_by(name: 'ii') if kcal < (Size.find_by(name: 'ii').kcal + 25)
    return Size.find_by(name: 'iii') if kcal < (Size.find_by(name: 'iii').kcal + 25)
    return Size.find_by(name: 'iv') if kcal < (Size.find_by(name: 'iv').kcal + 25)
    Size.find_by(name: 'v')
  end
end