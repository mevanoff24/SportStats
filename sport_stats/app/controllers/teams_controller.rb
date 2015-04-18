class TeamsController < ApplicationController

  before_action :set_user


  def index
    @teams = Team.all
    @away_team = Team.main["away_team"]["full_name"]
    @away_team_score = Team.main["away_period_scores"].inject(:+)
    @home_team = Team.main["home_team"]["full_name"]
    @home_team_score = Team.main["home_period_scores"].inject(:+)
    @away_pitchers = Team.main["away_pitchers"]
    @home_pitchers = Team.main["home_pitchers"]

    
    @away_pitchers.each do |player|
      if player["win"] == true
        player["display_name"]
      elsif player["loss"] == true
        player["display_name"]
      elsif player["save"] == true
        player["display_name"]
      end
    end

    # events["home_pitchers"].each do |player|
    #   if player["win"] == true
    #     puts "Winning Pitcher"
    #     ap player["display_name"]
    #   elsif player["loss"] == true
    #     puts "Losing Pitcher"
    #     ap player["display_name"]
    #   elsif player["save"] == true
    #     puts "Save"
    #     ap player["display_name"]
    #   end
    # end
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_user
    @user = User.find_by(uid: params[:uid])
  end



end
