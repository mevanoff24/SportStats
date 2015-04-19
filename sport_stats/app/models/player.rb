class Player < ActiveRecord::Base

	has_many :fantasy_teams, through: :fantasy_teams_players
	has_many :fantasy_teams_players

end
