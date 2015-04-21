require 'faker'

FactoryGirl.define do
  factory :fantasy_team do
  	name { Faker::Internet.user_name }
  end
end

