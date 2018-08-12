class CustomerMailer < ApplicationMailer
  default from: 'info@yoggie.com'
  layout 'mailer'

  def order_confirmation(customer)
    @customer = customer
    mail(
      to: @customer.user.email,
      subject: 'New Order!')
  end
end
