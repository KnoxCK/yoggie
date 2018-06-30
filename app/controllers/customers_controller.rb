class CustomersController < ApplicationController
  before_action :set_customer, only: [:edit, :update, :show]

  def new
    if current_user.customer
      redirect_to edit_customer_path(current_user.customer)
    else
      @customer = Customer.new(user_id: current_user.id)
    end
  end

  def create
    @customer = Customer.new(customer_params)
    @customer.user = current_user
    if @customer.save
      @customer.calculate_stats
      redirect_to new_customer_basket_path(@customer)
    else
      render :new
    end
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
