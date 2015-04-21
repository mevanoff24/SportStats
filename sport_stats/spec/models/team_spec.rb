require 'rails_helper'

RSpec.describe Team, type: :model do
	after(:all) do
		Team.destroy_all
	end
  it "adds a new team to user profile" do 
  	team = FactoryGirl.create :team
  	expect(team).to respond_to :user
  end
end

