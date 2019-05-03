class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :smoothies, :smoothie, :contact]

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

end
