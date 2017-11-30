class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :smoothies, :smoothie]

  def home
  end

  def smoothies
  end

  def smoothie
  end

end
