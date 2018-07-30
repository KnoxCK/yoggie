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

  private

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end
end
