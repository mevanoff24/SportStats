class FantasyTeam < ActiveRecord::Base

	belongs_to :user
	has_many :players, through: :fantasy_teams_player
	has_many :fantasy_teams_player
	accepts_nested_attributes_for :players, allow_destroy: true

end
