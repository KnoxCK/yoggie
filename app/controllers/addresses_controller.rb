class AddressesController < ApplicationController
  before_action :set_customer
  skip_before_action :authenticate_user!

  def edit
  end

  def update

    if @customer.address.check_postcode(address_params[:postcode])
      @customer.address.update(address_params)
      redirect_to new_customer_payment_path
    else
      @message = 'We do not deliver to this postcode'
      render :edit
    end
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = @customer.id
    if @address.check_postcode(address_params[:postcode])
      @address.save
      redirect_to new_customer_payment_path
    else
      @message = 'We do not deliver to this postcode'
      render :new
    end
  end

  def new
    @address = Address.new(customer_id: @customer.id)
  end

  private

  def set_customer
    @customer = Customer.friendly.find(params[:customer_id])
  end

  def address_params
    params.require(:address).permit(:address_line_one, :address_line_two,
                                    :address_line_three, :postcode,
                                    :delivery_instructions)
  end
end
