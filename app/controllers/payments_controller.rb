class PaymentsController < ApplicationController
  before_action :set_customer
  skip_before_action :authenticate_user!

  def new
    redirect_to new_customer_address_path if @customer.address.nil?
    @basket = @customer.basket
    @fee = @customer.tailored? ? Basket::SUBSCRIPTION_FEE[:tailored] : Basket::SUBSCRIPTION_FEE[:standard]
  end

  def create

    if @customer.stripe_id?
      customer = Stripe::Customer.retrieve(@customer.stripe_id)
    else
      customer = Stripe::Customer.create(
        source: params[:stripeToken],
        email:  params[:stripeEmail]
        )
    end

    subscription = Stripe::Subscription.create(
      customer: customer.id,
      plan: retrieve_plan_id
    )

    @customer.update(stripe_id: customer.id)

    if @customer.basket.status == 'active'
      cancel_previous_subscription
      # AdminMailer.subscription_change(@customer).deliver_now
    else
      # AdminMailer.new_order(@customer).deliver_now
    end

    @customer.basket.update(status: 'active', stripe_sub_id: subscription.id)
    CustomerMailer.order_confirmation(@customer).deliver_now
    flash[:notice] = "Thank you, your payment was successful."
    redirect_to customer_path(@customer)

  rescue Stripe::CardError => e
    flash[:alert] = "#{e.message} Please try again."
    redirect_to new_customer_payment_path(@customer)
  end

  protect_from_forgery

  private

  def retrieve_plan_id
    return 'plan_EKThXqZJTpyJIA' if @customer.basket.tailored?
    'plan_EKTiNGauVhaso5'
  end

  def cancel_previous_subscription
    subscription = Stripe::Subscription.retrieve(@customer.basket.stripe_sub_id)
    subscription.delete
  end

  def set_customer
    @customer = Customer.friendly.find(params[:customer_id])
  end
end
