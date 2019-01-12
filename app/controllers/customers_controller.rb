class CustomersController < ApplicationController
  before_action :set_customer, only: [:edit, :update, :show]

  def new
    if current_user.customer
      redirect_to edit_customer_path(current_user.customer)
    else
      if current_user.valid_postcode?
        @customer = Customer.new(user_id: current_user.id)
      else
        redirect_to postcode_checker_user_path(current_user)
      end
    end
  end

  def create
    @customer = Customer.new(customer_params)
    @customer.user = current_user
    if @customer.save
      @customer.calculate_stats if !@customer.standard?
      redirect_to new_customer_basket_path(@customer)
    else
      render :new
    end
  end

  def show
    @customer.check_status
    @basket = @customer.basket
    @status = determine_status
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      @customer.calculate_stats
      redirect_to new_customer_basket_path(@customer)
    else
      render :edit
    end
  end

  private

  def determine_status
    return 'Cancelled' if @customer.basket.status == 'cancelled'
    return 'Standard' if @customer.standard?
    return 'Tailored' if @customer.tailored?
  end

  def set_customer
    @customer = Customer.friendly.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :weight, :height,
                                     :activity_level, :goal, :age, :gender,
                                     :newsletter, :email, :phone)
  end
end
