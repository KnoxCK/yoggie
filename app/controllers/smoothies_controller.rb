class SmoothiesController < ApplicationController
  skip_before_action :authenticate_user!

  def index

    @smoothies = Smoothie.standard
    if user_signed_in? && current_user.customer.basket.nil?
      @basket = Basket.create(customer: current_user.customer)
    end
    if user_signed_in? && current_user.customer.tailored?
      if current_user.customer.protein.nil?
        redirect_to edit_customer_path(current_user.customer)
      else
      @smoothies = Smoothie.fetch_bundle(current_user.customer)
      end
    else
    end
  end

  def show
    @smoothie = Smoothie.all.find {|a| a.slug == params[:id]}
    @smoothie = Smoothie.all.find(params[:id]) if @smoothie == nil
    @basket = BasketSmoothie.new
    @badges = @smoothie.badges

    @small_ingredients = Ingredient.joins(:smoothie_ingredients)
      .where(smoothie_ingredients: {smoothie: @smoothie, large: false},
             superfood: nil).uniq

    @large_ingredients = Ingredient.joins(:smoothie_ingredients)
      .where(smoothie_ingredients: {smoothie: @smoothie, large: true},
             superfood: nil).uniq

    @special_ingredients = Ingredient.joins(:smoothie_ingredients)
      .where(smoothie_ingredients: {smoothie: @smoothie}).where(special: true).uniq
  end
end
