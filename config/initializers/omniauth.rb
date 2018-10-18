<<<<<<< HEAD
# config/initializers/omniauth.rb
=======
>>>>>>> leanne-feature-merchant
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV["GITHUB_CLIENT_ID"], ENV["GITHUB_CLIENT_SECRET"], scope: "user:email"
end
