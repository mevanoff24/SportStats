OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FB_AUTH_CLIENT_ID'], ENV['FB_AUTH_CLIENT_SECRET'], scope: 'email, user_about_me, publish_stream, user_birthday, user_hometown, user_friends, read_friendlists, friends_location, offline_access , publish_actions'
end

