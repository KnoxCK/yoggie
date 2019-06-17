class SmoothiesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @smoothies = Smoothie.standard
  end

  def show
    @smoothie = Smoothie.all.find {|a| a.slug == params[:id]}
    @basket = BasketSmoothie.new

    # @smoothie = Smoothie.find(params[:id])
  end

end
