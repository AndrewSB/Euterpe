require 'pp'
require 'yourub'

def get_url_from_track(q)
  options = { developer_key: 'AIzaSyDNvIzcRr1ONWjislGZTcz6rJOz0kVVkNs',
             application_name: 'Euterpe',
             application_version: 1.0,
             log_level: 3 }

  client = Yourub::Client.new(options)
  array = []

  client.search(query: q, max_results: 1) do |v|
    puts v
    array.append(v)
  end
  array[0]["id"]
end