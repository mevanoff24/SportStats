require 'rails_helper'
require 'spec_helper'

describe "FantasyTeams" do
  describe "GET /fantasy_teams" do
  	before do 
  		@user = User.create(name: "Matt")
  	end
    it "shows fantasy_team" do 
    	visit user_path(@user)
    	click_link "Create Fantasy Team"
    	fill_in "Name", with: "new team"
    	# fill_in "Player Name", with: "Seth Smith"
    	click_button "Create Team"
    	visit user_path(@user)
    	expect(page).to have_content("new team")
    end
  end
end

# if blank?
# delete
