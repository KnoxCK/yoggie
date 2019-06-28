class CustomersController < ApplicationController
  before_action :set_customer, only: [:edit, :update, :show, :update_subscription, :dashboard_edit, :dashboard_update, :update_status]
   # skip_before_action :authenticate_user!, only:[:choose_standard, :choose_]
  def new
    if current_user.customer
      if current_user.customer.basket.nil?
        @basket = Basket.create(customer: current_user.customer)
      end
      redirect_to edit_customer_path(current_user.customer)
    else
      if current_user.valid_postcode?
        @customer = Customer.create(user_id: current_user.id)
        if @customer.basket.nil?
          @basket = Basket.create(customer: current_user.customer)
        end
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
    if @customer.basket
      @customer.check_status
      @basket = @customer.basket
      @status = determine_status
      @sub_status = correct_subscription?
    end
  end


  def edit
  end

  def update
    @customer.update(customer_params)
    @customer.calculate_stats

    if @customer.standard? && @customer.address.nil?
      redirect_to new_customer_address_path(current_user.customer)
    elsif @customer.basket && @customer.basket.full?
      redirect_to new_customer_payment_path(@customer)
    else
      redirect_to smoothies_path
    end
  end


  def update_subscription
    if @customer.user.standard
      @customer.user.update(standard: params[:standard])
      redirect_to edit_customer_path(@customer)
    else
      @customer.user.update(standard: params[:standard])
      redirect_to smoothies_path(@customer)
    end
  end

  def dashboard_edit
  end


  def dashboard_update
    if @customer.update(customer_params)
      redirect_to customer_path(@customer)
    else
      render :edit
    end
  end


  def choose_standard

    if user_signed_in?
      current_user.standard = true
      current_user.save
      redirect_to smoothies_path
    end
  end

  def choose_custom
    if user_signed_in?
      current_user.standard = false
      current_user.save
      redirect_to smoothies_path
    end
  end

  def update_status
    if current_user.basket.status == 'cancelled'
      current_user.basket.update(status: '')
      redirect_to smoothies_path
    end
  end

  private

  def determine_status
    return 'Cancelled' if @customer.basket.status == 'cancelled'
    return 'Standard' if @customer.standard?
    return 'Tailored' if @customer.tailored?
  end

  def correct_subscription?
    return false unless @customer.basket&.stripe_sub_id
    subscription = Stripe::Subscription.retrieve(@customer&.basket&.stripe_sub_id)
    type = @customer&.basket&.tailored? ? :tailored : :standard
    subscription['plan']['amount'] == Basket::SUBSCRIPTION_FEE[type]
  end

  def set_customer
    @customer = Customer.friendly.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :weight, :height,
                                     :activity_level, :goal, :age, :gender,
                                     :newsletter, :email, :phone, :meals_per_day)
  end
end
