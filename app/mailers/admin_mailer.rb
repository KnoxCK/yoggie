class AdminMailer < ApplicationMailer
  default from: 'info@yoggie.co.uk'
  layout 'mailer'

  def new_order(customer)
    @customer = customer
    mail(
      to: 'charlie@yoggie.com',
      subject: 'New Order!')
  end

  def smoothie_change(basket)
    @basket = basket
    @customer = basket.customer
    mail(
      to: 'charlie@yoggie.com',
      subject: 'Smoothie Change')
  end

  def cancellation(customer)
    @customer = customer
    mail(
      to: 'charlie@yoggie.com',
      subject: 'Cancelled Subscription')
  end

  def subscription_change(customer)
    @customer = customer
    mail(
      to: 'charlie@yoggie.com',
      subject: 'Changed Subscription')
  end
end
