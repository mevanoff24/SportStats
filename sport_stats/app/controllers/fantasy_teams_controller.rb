class FantasyTeamsController < ApplicationController

  before_action :set_user

  def index
  end

  def show
  end

  def new
    @fantasy_team = FantasyTeam.new
    30.times { @fantasy_team.players.build }
  end

  def create
    p params
    @fantasy_team = FantasyTeam.new(name: params[:fantasy_team][:name], user_id: params[:user_id])
    if @fantasy_team.save
      counter = 0
      players_length = params[:fantasy_team][:players_attributes].length
      params_new = params[:fantasy_team][:players_attributes]
      # params_new.each do |player|
      #   added_player = Player.find_by(name: params_new["#{player}"][:name])
      #   @fantasy_team.players << added_player
      # end
      until counter == players_length
        added_player = Player.find_by(name: params_new["#{counter}"][:name])
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
    @user = User.find(params[:user_id])
  end
end
