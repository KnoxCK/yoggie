class AdminMailer < ApplicationMailer
  default from: 'info@yoggie.co.uk'
  layout 'mailer'

  def new_order(customer)
    # would be helpful to do this in a background job
    @customer = customer
    csv = @customer.generate_order_csv

    attachments["new_order_#{@customer&.basket&.stripe_sub_id}.csv"] = {mime_type: 'text/csv', content: csv}
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
      to: 'cancel@yoggie.com',
      subject: 'Cancelled Subscription')
  end

  def subscription_paused(customer)
    @customer = customer
    mail(
      to: 'cancel@yoggie.com',
      subject: 'Changed Subscription')
  end

  def subscription_change(customer)
    @customer = customer
    mail(
      to: 'charlie@yoggie.com',
      subject: 'Changed Subscription')
  end
end
