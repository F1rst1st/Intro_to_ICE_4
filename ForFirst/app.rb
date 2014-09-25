# app.rb
require 'sinatra'
require 'timezone'
require 'open-uri'
require 'json'




get '/' do
	erb :form
end


get '/form' do
	erb :form
end

post '/' do
	Timezone::Configure.begin do |c|
  		c.username = 'f1rst1st'
	end
	url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{params[:message]}&key=AIzaSyBQlFAz5Rvi7vpLTYlc1IF_RIzv_OHuJd0";
	content = open(url).read
	obj = JSON.parse(content)
	location = obj["results"][0]["geometry"]["location"]
	lat = location["lat"]
	lng = location["lng"]
	
	
	timezone = Timezone::Zone.new :latlon => [lat, lng]
	time = timezone.time Time.new 
	time = time.strftime("%I:%M %p")

	
	"The current time in #{params[:message]} is : <h1>#{time}</h1>"
end






