class BasketsController < ApplicationController
  before_action :set_customer
  skip_before_action :authenticate_user!

  def show
  end

  def edit
  end

  def update
  end

  def create
  end

  def new
    @basket = Basket.new(customer_id: @customer.id)
  end

  private

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end
end
