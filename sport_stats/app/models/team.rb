require 'net/http'
require 'openssl'
require 'json'
require 'date'

class Team < ActiveRecord::Base

	has_many :users


def self.main
    access_token = "53bfd032-95a6-412f-86e3-66ba6c473098"
    user_agent = "MyRobot/1.0 (mevanoff24@gmail.com)"

    # GONNA HAVE TO CHANGE
    # if User.first.teams != nil
    #     team1 = User.first.teams.find_by(name:"San Francisco Giants").name.downcase.gsub(" ", "-")
    # # team2 = schedule
    #     team2 = Team.find_by(name:"Arizona Diamondbacks").name.downcase.gsub(" ", "-")
    # end
    date_today = Date.today.to_s.gsub("-","").to_i
    date_today -=1
    yesterday_date = date_today.to_s

    host = "erikberg.com"
    sport = "mlb"
    method = "boxscore"
    # id = "#{yesterday_date}-#{team1}-at-#{team2}"
    id = "#{yesterday_date}-san-francisco-giants-at-arizona-diamondbacks"
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

    events = JSON.parse(data)

    # PLAYERS INFO PER GAME
    # events["away_batters"].each do |player|
    #   ap player["first_name"]
    #   ap player["last_name"]
    # ["away_pitchers"]
    # end


end

def self.schedule
    access_token = "53bfd032-95a6-412f-86e3-66ba6c473098"
    user_agent = "MyRobot/1.0 (mevanoff24@gmail.com)"

    date_today = Date.today.to_s.gsub("-","").to_i
    date_today -=1
    yesterday_date = date_today.to_s

    host = "erikberg.com"
    sport = nil
    method = "events"
    id = nil
    format = "json"
    parameters = {
        :sport => "mlb",
        :date  => "#{yesterday_date}"
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

    events = JSON.parse(data)

    team = User.first.teams.find_by(name:"San Francisco Giants").name.downcase.gsub(" ", "-")

    events['event'].each do |event|
        if event["home_team"]["team_id"] == team
            opposing_team = event["away_team"]["team_id"]
        elsif event["away_team"]["team_id"] == team
            opposing_team = event["home_team"]["team_id"]
        end
    end
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
