class AddressesController < ApplicationController
  before_action :set_customer
  skip_before_action :authenticate_user!

  def edit
  end

  def update
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = @customer.id
    if @address.save
      redirect_to new_customer_payment_path
    else
      render :new
    end
  end

  def new
    @address = Address.new(customer_id: @customer.id)
  end

  private

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  def address_params
    params.require(:address).permit(:address_line_one, :address_line_one,
                                    :address_line_one, :postcode,
                                    :delivery_instructions)
  end
end
