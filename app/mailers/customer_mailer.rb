class CustomerMailer < ApplicationMailer
  default from: 'henrietta@yoggie.co.uk'
  layout 'mailer'

  def order_confirmation(customer)
    @customer = customer
    mail(
      to: @customer.user.email,
      subject: 'New Order!')
  end

  def order_change(customer)
    @customer = customer
    mail(
      to: @customer.user.email,
      subject: 'Order successfully changed')
  end

  def order_paused(customer)
    @customer = customer
    mail(
      to: @customer.user.email,
      subject: 'Order successfully paused')
  end

  def order_cancelled(customer)
    @customer = customer
    mail(
      to: @customer.user.email,
      subject: 'Order successfully cancelled')
  end
end
