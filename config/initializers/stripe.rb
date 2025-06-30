# Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)

Rails.application.config.after_initialize do
  Stripe.api_key =
    ENV["STRIPE_SECRET_KEY"] ||
    Rails.application.credentials.dig(:stripe, :secret_key)

  if Stripe.api_key.blank?
    Rails.logger.warn "Stripe API key is missing. Set STRIPE_SECRET_KEY or add credentials."
  end
end