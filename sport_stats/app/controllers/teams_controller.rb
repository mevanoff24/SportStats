class TeamsController < ApplicationController

  # before_action :set_user

  def index
    @teams = Team.all
  end

  def create
    p params
    team = Team.find(params[:param1])
    user = User.find(params[:user_id]).teams
    user << team
    redirect_to user_path(current_user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end



end
