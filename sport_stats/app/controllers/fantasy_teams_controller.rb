class FantasyTeamsController < ApplicationController

  before_action :set_user

  def index
  end

  def show
  end

  def new

    @user = User.find(params[:user_id])
    @fantasy_team = FantasyTeam.new
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
