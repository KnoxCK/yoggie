class AdminMailer < ApplicationMailer
  default from: 'info@yoggie.com'
  layout 'mailer'

  def new_order(customer)
    @customer = customer
    mail(
      to: 'charlie@yoggie.com',
      subject: 'New Order!')
  end

  def smoothie_change
  end

  def cancellation
  end
end
