class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :smoothies, :smoothie, :about, :contact, :privacy, :terms, :faqs]

  def home
    # @popular = InstagramApi.user.recent_media
  end

  def smoothies
  end

  def smoothie
  end

  def about
  end

  def contact
  end

  def faqs
  end

  def privacy
  end

  def terms
  end


  def newsletter
  end

end
