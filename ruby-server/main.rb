require 'json'
require 'sinatra'

require './youtube'

get '/' do
	["Because my life is dope and I do dope shit",
	"<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>",
	"also, you can POST to /video with a q=\"SEARCH TERM\" and my dope self will return the first youtube id",
	"stay dope",
	"DOPE"].join("<br/><br/>")

end

post '/video' do 
	puts params["q"]
	vid = get_url_from_track(params["q"])

	vid
end