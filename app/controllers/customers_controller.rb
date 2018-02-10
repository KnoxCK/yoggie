class CustomersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_customer, only: [:edit, :update, :show]

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.create(customer_params)
    redirect_to customer_path(@customer)
  end

  def show
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
                                     :newsletter)
  end
end
