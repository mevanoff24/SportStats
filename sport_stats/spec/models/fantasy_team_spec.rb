require 'rails_helper'

RSpec.describe FantasyTeam, type: :model do
  after(:all) do
		FantasyTeam.destroy_all
	end
  it "adds a fantasy team for user" do 
  	fantasy_team = FactoryGirl.create :fantasy_team
  	expect(fantasy_team).to respond_to :user
  end

  it "has a valid factory" do
    FactoryGirl.create(:fantasy_team).should be_valid
  end

end
