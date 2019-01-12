class CustomerMailer < ApplicationMailer
  default from: 'henrietta@yoggie.co.uk'
  layout 'mailer'

  def order_confirmation(customer)
    @customer = customer
    mail(
      to: @customer.user.email,
      subject: 'New Order!')
  end
end
