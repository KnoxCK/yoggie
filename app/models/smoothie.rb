class Smoothie < ApplicationRecord
  has_many :basket_smoothies
  has_many :smoothie_ingredients
  has_many :ingredients, through: :smoothie_ingredients
  has_many :smoothie_badges
  has_many :badges, through: :smoothie_badges
  has_one :nutri_info
  belongs_to :group
  belongs_to :size
  has_many :baskets, through: :basket_smoothies

  mount_uploader :image, SmoothieUploader

  scope :standard, -> { where(group_id: Group.find_by(name: 'Std'), size_id: 3) }

  def slug
    name.parameterize
  end

  def self.fetch_bundle(customer)
    return standard if customer.standard?
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

  def standard?
    group.name == 'Std'
  end

  def tailored?
    !standard?
  end
end
