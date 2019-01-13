class Badge < ApplicationRecord
  has_many :smoothie_badges
  has_many :smoothies, through: :smoothie_badges

  mount_uploader :image, BadgeUploader
end
