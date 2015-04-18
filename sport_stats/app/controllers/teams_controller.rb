class TeamsController < ApplicationController

  # before_action :set_user
  
  def index
    @teams = Team.all
    @away_team = Team.main["away_team"]["full_name"]
    @away_team_score = Team.main["away_period_scores"].inject(:+)
    @home_team = Team.main["home_team"]["full_name"]
    @home_team_score = Team.main["home_period_scores"].inject(:+)
    @away_pitchers = Team.main["away_pitchers"]
    @home_pitchers = Team.main["home_pitchers"]
  end

  private

  def set_user
    @user = User.find(params[:id])
  end



end
