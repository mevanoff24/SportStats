class User < ActiveRecord::Base

	has_many :teams, dependent: :destroy
	has_many :fantasy_teams, dependent: :destroy

	def self.from_omniauth(auth)
    user = User.find_or_create_by(provider: auth.provider, uid: auth.uid)
    user.name = auth.info.name
    user.email = auth.info.email

    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)

    user.save!

    user
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end

end
