def get_url_from_track(query, number)
  video = YoutubeSearch.search(query)[0]
  puts video
  pp "just printed video ^"
  video_id = video["video_id"]
  puts "video_id" + video_id
  send_message(video["title"], number)
  uri = URI.parse("http://54.149.169.73:3000/convert?url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3D" + video_id)
  response = Net::HTTP.get_response(uri)
  pp response.body
  pp "making call"
  make_call(video_id, video, number)
  pp "made call"
  video
end