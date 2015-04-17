require "json"
require "open-uri"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


teams = JSON.load(open("/Users/mattevanoff/Desktop/projects/SportStats/sport_stats/public/MLB_teams.json").read)
# teams_img = JSON.load(open("/Users/mattevanoff/Desktop/projects/SportStats/sport_stats/public/MLB_images.json").read)
teams['collection1'].each do |team|
	# teams_img['collection1'].each do |img|

	Team.create(name: team["name"]["text"], city: team["city"]["text"], stadium: team["stadium"]["text"], image: team["image"]["src"])

	end
# end




