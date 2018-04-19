class CustomersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_customer, only: [:edit, :update, :show]

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      # calculate shit and save to customer
    else
      render :new
    end
    redirect_to new_customer_basket_path(@customer)
  end

  def show
    @basket = @customer.basket
  end

  def edit
  end

  def update
    @customer.update(customer_params)
    redirect_to customer_path(@customer)
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :weight, :height,
                                     :activity_level, :goal, :age, :gender,
                                     :newsletter, :email, :phone)
  end
end
