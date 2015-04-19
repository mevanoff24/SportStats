class FantasyTeamsController < ApplicationController

  before_action :set_user

  def index
  end

  def show
  end

  def new
    @user = User.find(params[:user_id])
    @fantasy_team = FantasyTeam.new
    3.times { @fantasy_team.players.build }
  end

  def create
    p params
    @fantasy_team = FantasyTeam.new(name: params[:fantasy_team][:name], user_id: params[:user_id])
    if @fantasy_team.save
      flash[:notice] = "Successfully created team"
      redirect_to user_path(current_user)
    else
      render :action => 'new'
    end
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
