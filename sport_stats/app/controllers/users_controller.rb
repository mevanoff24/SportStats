class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@user_teams = @user.teams
	end
end
