class CustomersController < ApplicationController
  before_action :set_customer, only: [:edit, :update, :show, :update_subscription, :dashboard_edit, :dashboard_update, :update_status]
  skip_before_action :authenticate_user!, only:[:choose_standard, :choose_custom]

  def new
    if current_user.customer && !current_user.standard
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
    else
      @basket = Basket.create(customer: current_user.customer)
    end

    @next_delivery_date_string = @basket.next_delivery_date_string
  end


  def edit
  end

  def update
    @customer.update(customer_params)

    if @customer.standard? && @customer.address.nil?
      if @customer.basket && @customer.basket.full?
        redirect_to new_customer_address_path(current_user.customer)
      else
        redirect_to smoothies_path
      end
    elsif @customer.basket && @customer.basket.full?
      @customer.calculate_stats if !@customer.standard?
      redirect_to new_customer_payment_path(@customer)
    elsif !@customer.standard?
      @customer.calculate_stats
      redirect_to smoothies_path
    else
      redirect_to smoothies_path
    end
  end


  def update_subscription
    # basket = @customer.basket
    # if basket
    #   BasketSmoothie.where(basket_id: basket.id).destroy_all
    #   basket.update(status: 'pending')
    # end

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
    original_customer_updated_at = @customer.updated_at

    if @customer.update(customer_params)
      @customer.calculate_stats if !@customer.standard?

      if @customer.basket&.active? && @customer.updated_at != original_customer_updated_at
        # Send order changed emails if attributes changed
        AdminMailer.subscription_change(@customer).deliver_now
      end

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
    else
      session[:standard] = true
      redirect_to new_user_registration_path
    end

  end

  def choose_custom
    if user_signed_in?
      current_user.standard = false
      current_user.save
      redirect_to smoothies_path
    else
      session[:standard] = false
      redirect_to new_user_registration_path
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
