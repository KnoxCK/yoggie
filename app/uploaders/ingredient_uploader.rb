class IngredientUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
