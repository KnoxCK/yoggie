class Article < ApplicationRecord
  mount_uploader :cover_image, PhotoUploader

  validates :title, :content, :description, :date, presence: true

  def slug
    title.parameterize
  end
end
