class AddressesController < ApplicationController
  before_action :set_customer
  skip_before_action :authenticate_user!
  def edit
  end

  def update
  end

  def create
  end

  def new

  end

  private

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end
end
