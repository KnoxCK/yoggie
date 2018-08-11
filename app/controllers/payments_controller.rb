class PaymentsController < ApplicationController
  before_action :set_customer
  skip_before_action :authenticate_user!

  def new
    @basket = @customer.basket
  end

  def create

    if @customer.stripe_customer_id?
      customer = Stripe::Customer.retrieve(@customer.stripe_customer_id)
      plan = Stripe::Plan.retrieve("#{@customer.email}-#{@basket.id}")
    else
      customer = Stripe::Customer.create(
        source: params[:stripeToken],
        email:  @customer.email,
        )
      plan = Stripe::Plan.create(
        name:     "Customer #{@customer.id} - #{@customer.full_name}, Basket ##{@customer.basket.id}",
        id:       "#{@customer.email}-#{@basket.id}",
        interval: "week",
        currency: "gbp",
        amount:   4900,
        )
    end

    Stripe::Subscription.create(
      customer: customer.id,
      plan: plan.id,
    )


    @customer.update(stripe_customer_id: customer.id)
    # @customer.basket.update(status: 'active')
    # OrderMailer.order_confirmation(@customer).deliver_now
    # OrderMailer.order_received(@customer).deliver_now
    flash[:notice] = "Thank you, your payment was successful."
    redirect_to root_path

  rescue Stripe::CardError => e
    @order.update(state: 'Error')
    flash[:alert] = "#{e.message} Please try again."
    redirect_to new_customer_payment_path(@customer)
  end

  protect_from_forgery

  private

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end
end
