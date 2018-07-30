Rails.configuration.stripe = {
  :publishable_key => 'pk_test_hveOGYFAnnyFAoTY5OV01p26',
  :secret_key      => 'sk_test_8CoEsV9ijSTj6OBoyQPjJl1C'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
