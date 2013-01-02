if Rails.env == "development"
  STRIPE_API_KEY = "kz8KSxX4mKwC0OZatiWc0KlksBvwzpp9"
  ENV['STRIPE_PUBLIC_KEY'] = "pk_tr674IjCjR282cGPK4YW00WucwNcQ"
end

Stripe.api_key = ENV['STRIPE_API_KEY']
STRIPE_PUBLIC_KEY = ENV['STRIPE_PUBLIC_KEY']