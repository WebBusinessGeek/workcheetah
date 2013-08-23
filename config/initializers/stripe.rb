if Rails.env.development? || Rails.env.test? || Rails.env.staging?
  Stripe.api_key = "sk_test_wPMSw7QQnYZkjWBKvq0hUxFn"
  STRIPE_PUBLIC_KEY = "pk_test_h80n7D2FsGImlQj8pt8ddBHB"
end

if Rails.env.production?
  Stripe.api_key = "sk_live_ZCeSy10vat1bFAY8eRMZqXkh"
  STRIPE_PUBLIC_KEY = "pk_live_RykFRUMTipol5ciwHTk8ZeIK"
  # Stripe.api_key = ENV['STRIPE_PRIVATE_KEY']
  # STRIPE_PUBLIC_KEY = ENV['STRIPE_PUBLIC_KEY']
end