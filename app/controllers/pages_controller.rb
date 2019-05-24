class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :smoothies, :smoothie, :contact, :privacy]

  def home
  end

  def smoothies
  end

  def smoothie
  end

  def contact
  end

  def faqs 
  end

  def privacy
  end

end
