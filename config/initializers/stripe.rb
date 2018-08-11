Rails.configuration.stripe = {
  :publishable_key => 'pk_test_hveOGYFAnnyFAoTY5OV01p26',
  :secret_key      => 'sk_test_XZNk9Ce7XxNwW47pKIbORrPl'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
