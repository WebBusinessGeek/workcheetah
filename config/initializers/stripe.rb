if Rails.env.development? || Rails.env.test?
  Stripe.api_key = "LL7PGWzGIBa1v61qk1LprEZXqwo9GYtE"
  STRIPE_PUBLIC_KEY = "pk_HsYtVBbmyTRHjE3haYtTQLM4Lje4v"
end

if Rails.env.production?
  Stripe.api_key = ENV['STRIPE_PRIVATE_KEY']
  STRIPE_PUBLIC_KEY = ENV['STRIPE_PUBLIC_KEY']
end