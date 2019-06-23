class SmoothiesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @smoothies = Smoothie.standard
    if user_signed_in? && current_user.customer.basket.nil?
      @basket = Basket.create(customer: current_user.customer)
    end
  end

  def show
    @smoothie = Smoothie.all.find {|a| a.slug == params[:id]}
    @basket = BasketSmoothie.new

    # @smoothie = Smoothie.find(params[:id])
  end

end
