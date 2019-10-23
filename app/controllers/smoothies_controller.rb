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

    small_smooth_ingred = @smoothie.smoothie_ingredients.where(large: false)
    @small_ingredients = small_smooth_ingred.map do |small_smoothie_ingredient|
      small_smoothie_ingredient.ingredient
    end

    @small_ingredients = @small_ingredients.uniq

    # @smoothie = Smoothie.find(params[:id])
  end

end
