class AdminMailer < ApplicationMailer
  default from: 'info@yoggie.co.uk'
  layout 'mailer'

  def new_order(customer)
    #charlie@yoggie.com
    # would be helpful to do this in a background job
    @customer = customer
    csv = @customer.generate_order_csv

    attachments["new_order_#{@customer&.basket&.stripe_sub_id}.csv"] = {mime_type: 'text/csv', content: csv}
    mail(
      to: 'admin@yoggie.co.uk',
      subject: 'New Order!')
  end

  def smoothie_change(customer)
    #charlie@yoggie.com
    @customer = customer
    csv = @customer.generate_order_csv

    attachments["smoothie_change_#{@customer&.basket&.stripe_sub_id}.csv"] = {mime_type: 'text/csv', content: csv}
    mail(
      to: 'admin@yoggie.co.uk',
      subject: 'Smoothie Change')
  end

  def address_change(customer)
    #charlie@yoggie.com
    @customer = customer
    mail(
      to: 'admin@yoggie.co.uk',
      subject: 'Smoothie Change')
  end

  def cancellation(customer)
    #cancel@yoggie.com
    @customer = customer
    mail(
      to: 'admin@yoggie.co.uk',
      subject: 'Cancelled Subscription')
  end

  def subscription_paused(customer)
    #cancel@yoggie.com
    @customer = customer
    mail(
      to: 'admin@yoggie.co.uk',
      subject: 'Paused Subscription')
  end

  def subscription_change(customer)
    #charlie@yoggie.com
    @customer = customer
    csv = @customer.generate_order_csv

    attachments["subscription_change_#{@customer&.basket&.stripe_sub_id}.csv"] = {mime_type: 'text/csv', content: csv}
    mail(
      to: 'admin@yoggie.co.uk',
      subject: 'Changed Subscription')
  end
end
