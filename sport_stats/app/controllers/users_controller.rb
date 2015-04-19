class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@user_teams = @user.teams

    @away_team = Team.main["away_team"]["full_name"]
    @away_team_score = Team.main["away_period_scores"].inject(:+)
    @home_team = Team.main["home_team"]["full_name"]
    @home_team_score = Team.main["home_period_scores"].inject(:+)
    @away_pitchers = Team.main["away_pitchers"]
    @home_pitchers = Team.main["home_pitchers"]

   	@fantasy_teams = FantasyTeam.find_by(user_id: params[:id])
	end
end
