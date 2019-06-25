class BasketsController < ApplicationController
  before_action :set_customer, except: :basket_confirmation
  skip_before_action :authenticate_user!

  def show
  end

  def basket_confirmation
    @basket = Basket.find(params[:basket_id])
    @customer = @basket.customer
    @status = determine_status
  end

  def edit
      @smoothies = Smoothie.fetch_bundle(@customer)
  end

  def update
    @basket = Basket.find_or_create_by!(customer_id: @customer.id)
    prev_status = @basket.tailored?
    @basket.update(basket_params) if params[:basket]
    if check_quantity
      BasketSmoothie.where(basket_id: @basket.id).destroy_all
      @basket.add_smoothies(params[:quantity])
      after_basket_path(prev_status)
    else
      @smoothies = Smoothie.fetch_bundle(@customer)
      @message = 'Please select a total of 5 smoothies.'
      redirect_to new_customer_basket_path, notice: @message
    end
  end

  def create
    @basket = Basket.find_or_create_by!(basket_params)
    @basket.update(basket_params) if params[:basket]
    if check_quantity
      @basket.add_smoothies(params[:quantity])
      after_basket_path(@basket.tailored)
    else
      @smoothies = Smoothie.fetch_bundle(@customer)
      @message = 'Please select a total of 5 smoothies.'
      render :show
    end
  end

  def add_to_basket
    # find customer
     # check if they have a basket
    if @customer.basket
      @basket = @customer.basket
    else
      @basket = Basket.create(customer: @customer)
    end
    # finding which smoothie we clicked on add to basket
    # url: products/1/orders
    # if @basket.smoothies.count >= 5
    # # raise
    #   after_basket_path(@basket.tailored)
    # else
      @smoothie = Smoothie.find(params[:smoothie_id])
      @quantity = params[:quantity].to_i
      BasketSmoothie.where(smoothie: @smoothie, basket: @basket).destroy_all
      available = 5 - @basket.smoothies.count
      if available > @quantity
        @quantity.times do
          @basket_smoothie = BasketSmoothie.create(smoothie: @smoothie, basket: @basket)
        end
      else
        available.times do
          @basket_smoothie = BasketSmoothie.create(smoothie: @smoothie, basket: @basket)
        end
      end
      if @basket.smoothies.count >= 5
        @message = "You have a total of 5 smoothies."
      else
        @message = "Smoothies added, you need another #{5 - @basket.smoothies.length}."
      end

      redirect_to smoothies_path, notice: @message
  end



  def new
    @basket = Basket.find_or_initialize_by(customer_id: @customer.id)
    @smoothies = Smoothie.fetch_bundle(@customer)
  end

  def cancel_subscription
    @basket = Basket.find(params[:id])
    subscription = Stripe::Subscription.retrieve(@basket.stripe_sub_id)
    subscription.delete
    @basket.update(status: 'cancelled')
    AdminMailer.cancellation(@customer).deliver
    redirect_to customer_path(@basket.customer), notice: 'Your subscription has been cancelled'
  end

  def pause_subscription
    @basket = Basket.find(params[:id])
    subscription = Stripe::Subscription.retrieve(@basket.stripe_sub_id)
    subscription.delete
    @basket.update(status: 'pending')
    AdminMailer.subscription_paused(@customer).deliver
    redirect_to customer_path(@basket.customer), notice: 'Your subscription has been paused'
  end

  private

  def determine_status
    return 'Cancelled' if @customer.basket.status == 'cancelled'
    return 'Standard' if @customer.standard?
    return 'Tailored' if @customer.tailored?
  end

  def set_customer
    @customer = Customer.friendly.find(params[:customer_id])
  end

  def basket_params
    params.require(:basket).permit(:customer_id, :tailored)
  end

  def check_quantity
    total = 0
    params[:quantity].each_value {|q| total += q.to_i }
    total == 5
  end

  def send_change_notification
    AdminMailer.smoothie_change(@basket).deliver
  end

  def after_basket_path(prev_status)
    if @basket.stripe_sub_id && correct_subscription?
      send_change_notification unless prev_status == @basket.tailored?
      redirect_to customer_path(@customer)
    elsif @customer.address.nil?
      redirect_to new_customer_address_path
    else
      redirect_to new_customer_payment_path
    end
  end

  def correct_subscription?
    subscription = Stripe::Subscription.retrieve(@basket&.stripe_sub_id)
    type = @basket.tailored? ? :tailored : :standard
    subscription['plan']['amount'] == Basket::SUBSCRIPTION_FEE[type]
  end
end
