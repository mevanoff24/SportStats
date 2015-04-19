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

teams['collection1'].each do |team|

	Team.create(name: team["name"]["text"], city: team["city"]["text"], stadium: team["stadium"]["text"], image: team["image"]["src"])

end

players = JSON.load(open("/Users/mattevanoff/Desktop/projects/SportStats/sport_stats/public/MLB_players.json").read)

players["collection2"].each do |player|

	Player.create(name: player["property3"]["text"])

end
