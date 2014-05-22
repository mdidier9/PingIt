OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["FACEBOOK_KEY"]="764749046879221", ENV["FACEBOOK_SECRET"]='deae0216c677f64553f7a7aad2ea3686'
end

# does this change show?