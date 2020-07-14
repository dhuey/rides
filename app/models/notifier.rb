class Notifier
  attr_accessor :ride, :pickup_time, :requester_gender, :number_of_passengers

  require 'net/http'
  require 'uri'
  require 'json'

  def initialize(ride)
    @ride = ride
    @pickup_time = @ride.formatted_pickup_time
    @requester_gender = @ride.requester_gender
    @number_of_passengers = @ride.number_of_passengers
  end

  def request_ride
    if @requester_gender == "male"
      uri = URI.parse("https://api.groupme.com/v3/bots/post")
      request = Net::HTTP::Post.new(uri)
      request.content_type = "application/json"
      request.body = JSON.dump({
        "bot_id" => ENV["MALE_GROUPME"],
        "text" => "A new ride for #{@number_of_passengers} passenger(s) has been requested for #{@pickup_time}. #{Rails.application.routes.url_helpers.ride_url(@ride)}"
      })

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
    else
      uri = URI.parse("https://api.groupme.com/v3/bots/post")
      request = Net::HTTP::Post.new(uri)
      request.content_type = "application/json"
      request.body = JSON.dump({
        "bot_id" => ENV["FEMALE_GROUPME"],
        "text" => "A new ride for #{@number_of_passengers} passenger(s) has been requested for #{@pickup_time}. #{Rails.application.routes.url_helpers.ride_url(@ride)}"
      })

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
    end
  end
end





# response.code
# response.body