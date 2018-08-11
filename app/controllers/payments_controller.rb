class PaymentsController < ApplicationController
  before_action :set_customer
  skip_before_action :authenticate_user!

  def new
  end

  def create
    @amount = 500

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'gbp'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def create
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  @customer.email,
      )


      if @order.state == 'Error'
        plan = Stripe::Plan.retrieve("#{@customer.email}-#{@order.id}")
      else
        plan = Stripe::Plan.create(
          name:     "#{@customer.full_name}-#{@customer_plan.meal_plan.name}
                      Plan - Order ##{@order.id}",
          id:       "#{@customer.email}-#{@order.id}",
          interval: "week",
          currency: "gbp",
          amount:   @order.total_price_pennies,
          )
      end

      Stripe::Subscription.create(
        customer: customer.id,
        plan: plan.id,
      )


    @customer.update(stripe_customer_id: customer.id)
    @order.update(state: 'Paid')
    OrderMailer.order_confirmation(@customer).deliver_now
    OrderMailer.order_received(@customer).deliver_now
    flash[:notice] = "Thank you, your payment was successful."
    redirect_to customer_customer_plan_order_path(@customer, @customer_plan, @order)

  rescue Stripe::CardError => e
    @order.update(state: 'Error')
    flash[:alert] = "#{e.message} Please try again."
    redirect_to new_customer_customer_plan_order_payment_path(@customer, @customer_plan, @order)
  end

  protect_from_forgery

  private

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end
end
