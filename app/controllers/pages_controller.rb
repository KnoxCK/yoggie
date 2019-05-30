class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :smoothies, :smoothie, :contact, :privacy, :terms]

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

  def terms
  end

end
