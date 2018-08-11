class BasketsController < ApplicationController
  before_action :set_customer
  skip_before_action :authenticate_user!

  def show
  end

  def edit
  end

  def update
    @basket = Basket.find_or_create_by(customer_id: params[:customer_id])
    if check_quantity
      after_basket_path
    else
      @smoothies = Smoothie.fetch_bundle(@customer)
      @message = 'Please select a total of 5 smoothies.'
      render :new
    end
  end

  def create
    @basket = Basket.create(customer_id: params[:customer_id])
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
    @basket = Basket.new(customer_id: @customer.id)
    @smoothies = Smoothie.fetch_bundle(@customer)
  end

  private

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  def basket_params
    params.require(:basket).permit(:customer_id)
  end

  def check_quantity
    total = 0
    params[:quantity].each_value {|q| total += q.to_i }
    total == 5
  end

  def after_basket_path
    if !@customer.address.nil?
      redirect_to new_customer_payment_path
    else
      redirect_to new_customer_address_path
    end
  end
end
