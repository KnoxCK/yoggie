class AddressesController < ApplicationController
  before_action :set_customer
  skip_before_action :authenticate_user!

  def edit
  end

  def update

    if @customer.address.check_postcode(address_params[:postcode])
      address_updated_at = @customer.address.updated_at
      @customer.address.update(address_params)

      if @customer.basket&.active? && @customer.address.updated_at != address_updated_at
        # Send address changed emails if attributes changed
        AdminMailer.address_change(@customer).deliver_now
        CustomerMailer.address_change(@customer).deliver_now
      end

      update_customer_last_name
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
      update_customer_last_name
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

  def update_customer_last_name
    last_name = params[:address][:last_name]
    return unless last_name.present? && last_name != @customer.last_name

    @customer.update(last_name: last_name)
  end

  def address_params
    params.require(:address).permit(:address_line_one, :address_line_two,
                                    :address_line_three, :postcode,
                                    :delivery_instructions)
  end
end
