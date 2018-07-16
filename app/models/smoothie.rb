class Smoothie < ApplicationRecord
  has_many :basket_smoothies

  def self.fetch_bundle(protein)
    group = group_name(protein)
    where(group: group)
  end

  def self.group_name(protein)
    return 'A' if protein < 25
    return 'B' if protein < 35
    'C'
  end
end
