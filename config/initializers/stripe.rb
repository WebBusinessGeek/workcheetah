if Rails.env.development? || Rails.env.test?
  Stripe.api_key = "sk_test_wPMSw7QQnYZkjWBKvq0hUxFn"
  STRIPE_PUBLIC_KEY = "pk_test_h80n7D2FsGImlQj8pt8ddBHB"
end

if Rails.env.production?
  Stripe.api_key = ENV['STRIPE_PRIVATE_KEY']
  STRIPE_PUBLIC_KEY = ENV['STRIPE_PUBLIC_KEY']
end