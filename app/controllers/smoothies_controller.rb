class SmoothiesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @smoothies = Smoothie.standard
  end
end
