require 'net/http'
require 'openssl'
require 'json'
require 'date'

class Team < ActiveRecord::Base

	has_many :users

    private

def self.main
    # Replace with your access token
    access_token = "53bfd032-95a6-412f-86e3-66ba6c473098"
    # Replace with your bot name and email/website to contact if there is a problem
    # e.g., "mybot/0.1 (https://erikberg.com/)"
    user_agent = "MyRobot/1.0 (mevanoff24@gmail.com)"
    # GONNA HAVE TO CHANGE
    team1 = User.first.teams.find_by(name:"San Francisco Giants").name.downcase.gsub(" ", "-")
    team2 = Team.find_by(name:"Arizona Diamondbacks").name.downcase.gsub(" ", "-")
    host = "erikberg.com"
    sport = "mlb"
    method = "boxscore"
    id = "20150417-#{team1}-at-#{team2}"
    format = "json"
    parameters = {
        :sport => "mlb",
        :date  => nil
    }
    uri = self.build_uri(host, sport, method, id, format, parameters)

    data = nil
    Net::HTTP.start(uri.host, uri.port,
                    :use_ssl     => true,
                    :verify_mode => OpenSSL::SSL::VERIFY_PEER) do |http|
        req = Net::HTTP::Get.new(uri.request_uri)
        req['Authorization'] = "Bearer " + access_token
        req['User-agent'] = user_agent
        res = http.request(req)
        case res
        when Net::HTTPSuccess then
            data = res.body
        else
            puts "Error retrieving file: #{res.code} #{res.message}"
            puts res.body
            exit(1)
        end
    end

    # Parses the JSON content and returns a reference
    # to Events (https://erikberg.com/api/methods/events)
    events = JSON.parse(data)
    #SCORE
    # ap events["away_team"]["full_name"]
    # ap events["away_period_scores"].inject(:+)
    # ap events["home_team"]["full_name"]
    # ap events["home_period_scores"].inject(:+)
    
    # events["away_pitchers"].each do |player|
    #   if player["win"] == true
    #     puts "Winning Pitcher"
    #     ap player["display_name"]
    #   elsif player["loss"] == true
    #     puts "Losing Pitcher"
    #     ap player["display_name"]
    #   elsif player["save"] == true
    #     puts "Save"
    #     ap player["display_name"]
    #   end
    # end

    # events["home_pitchers"].each do |player|
    #   if player["win"] == true
    #     puts "Winning Pitcher"
    #     ap player["display_name"]
    #   elsif player["loss"] == true
    #     puts "Losing Pitcher"
    #     ap player["display_name"]
    #   elsif player["save"] == true
    #     puts "Save"
    #     ap player["display_name"]
    #   end
    # end

    # PLAYERS INFO PER GAME
    # events["away_batters"].each do |player|
    #   ap player["first_name"]
    #   ap player["last_name"]
    # ["away_pitchers"]
    # end

    # Create DateTime object using the ISO 8601 formatted events_date
    # date = DateTime.iso8601(events['events_date'])

    # printf("Events on %s\n\n", date.strftime("%A, %B %e, %Y"));
    # printf("%-35s %5s %34s\n", "Time", "Event", "Status");

    # Loop through each Event (https://erikberg.com/api/objects/event)
    # events['event'].each { |event|
    #     event_time = DateTime.iso8601(event['start_date_time'])

    #     # Get team objects (https://erikberg.com/api/objects/team)
    #     away_team = event['away_team']
    #     home_team = event['home_team']

    #     printf("%-12s %24s vs. %-24s %9s\n",
    #       event_time.strftime("%l:%M %p"),
    #       away_team['full_name'],
    #       home_team['full_name'],
    #       event['event_status']);
    # }
end

def self.schedule
    # Replace with your access token
    access_token = "53bfd032-95a6-412f-86e3-66ba6c473098"
    # Replace with your bot name and email/website to contact if there is a problem
    # e.g., "mybot/0.1 (https://erikberg.com/)"
    user_agent = "MyRobot/1.0 (mevanoff24@gmail.com)"

    host = "erikberg.com"
    sport = nil
    method = "events"
    id = nil
    format = "json"
    parameters = {
        :sport => "mlb",
        :date  => "20150417"
    }
    uri = self.build_uri(host, sport, method, id, format, parameters)

    data = nil
    Net::HTTP.start(uri.host, uri.port,
                    :use_ssl     => true,
                    :verify_mode => OpenSSL::SSL::VERIFY_PEER) do |http|
        req = Net::HTTP::Get.new(uri.request_uri)
        req['Authorization'] = "Bearer " + access_token
        req['User-agent'] = user_agent
        res = http.request(req)
        case res
        when Net::HTTPSuccess then
            data = res.body
        else
            puts "Error retrieving file: #{res.code} #{res.message}"
            puts res.body
            exit(1)
        end
    end

    # Parses the JSON content and returns a reference
    # to Events (https://erikberg.com/api/methods/events)
    events = JSON.parse(data)
    # # Create DateTime object using the ISO 8601 formatted events_date
    # date = DateTime.iso8601(events['events_date'])

    # printf("Events on %s\n\n", date.strftime("%A, %B %e, %Y"));
    # printf("%-35s %5s %34s\n", "Time", "Event", "Status");

    # # Loop through each Event (https://erikberg.com/api/objects/event)
    # events['event'].each { |event|
    #     event_time = DateTime.iso8601(event['start_date_time'])

    #     # Get team objects (https://erikberg.com/api/objects/team)
    #     away_team = event['away_team']
    #     home_team = event['home_team']

    #     printf("%-12s %24s vs. %-24s %9s\n",
    #       event_time.strftime("%l:%M %p"),
    #       away_team['full_name'],
    #       home_team['full_name'],
    #       event['event_status']);
    # }
end

# See https://erikberg.com/api/methods Request URL Convention for
# an explanation
def self.build_uri(host, sport, method, id, format, parameters)
    path = "/"
    path += [sport, method, id].compact * "/"
    path += "." + format
    uri = URI::HTTPS.new('https', nil, host, nil, nil, path, nil, nil, nil)
    if parameters
        uri.query = URI.encode(parameters.map{|k,v| "#{k}=#{v}"}.join("&"))
    end
    return uri
end



end
