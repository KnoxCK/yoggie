class BasketsController < ApplicationController
  before_action :set_customer
  skip_before_action :authenticate_user!

  def show
  end

  def edit
  end

  def update
  end

  def create
    @basket = Basket.new(basket_params)
    if @basket.save
      redirect_to new_customer_address_path
    else
      @shakes = [1,2,3]
      render :new
    end
  end

  def new
    @basket = Basket.new(customer_id: @customer.id)
    @shakes = [1,2,3]
  end

  private

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  def basket_params
    params.require(:basket).permit(:customer_id, :shake_id)
  end
end
