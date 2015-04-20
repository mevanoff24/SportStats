class FantasyTeamsController < ApplicationController

  before_action :set_user

  def index
  end

  def show
  end

  def new
    @user = User.find(params[:user_id])
    @fantasy_team = FantasyTeam.new
    27.times { @fantasy_team.players.build }
  end

  def create
    p params
    player_length = params[:fantasy_team][:players_attributes].length
    @fantasy_team = FantasyTeam.new(name: params[:fantasy_team][:name], user_id: params[:user_id])
    if @fantasy_team.save
      parmas_new = params[:fantasy_team][:players_attributes]
      counter = 0
      until counter == params[:fantasy_team][:players_attributes].length
        added_player = Player.find_by(name: parmas_new["#{counter}"][:name])
        @fantasy_team.players << added_player
        counter += 1
      end    
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
