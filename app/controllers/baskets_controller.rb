class BasketsController < ApplicationController
  before_action :set_customer
  skip_before_action :authenticate_user!

  def show
  end

  def edit
    @smoothies = Smoothie.fetch_bundle(@customer)
  end

  def update
    @basket = Basket.find_or_create_by!(customer_id: @customer.id)
    @basket.update(basket_params) if params[:basket]
    if check_quantity
      BasketSmoothie.where(basket_id: @basket.id).destroy_all
      @basket.add_smoothies(params[:quantity])
      send_change_notification if @basket.stripe_sub_id
      after_basket_path
    else
      @smoothies = Smoothie.fetch_bundle(@customer)
      @message = 'Please select a total of 5 smoothies.'
      render :edit
    end
  end

  def create
    @basket = Basket.find_or_create_by!(basket_params)
    @basket.update(basket_params) if params[:basket]
    if check_quantity
      @basket.add_smoothies(params[:quantity])
      after_basket_path
    else
      @smoothies = Smoothie.fetch_bundle(@customer)
      @message = 'Please select a total of 5 smoothies.'
      render :new
    end
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

  private

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

  def after_basket_path
    if @customer.basket.status == 'active'
      redirect_to customer_path(@customer)
    elsif @customer.address.nil?
      redirect_to new_customer_address_path
    else
      redirect_to new_customer_payment_path
    end
  end
end
