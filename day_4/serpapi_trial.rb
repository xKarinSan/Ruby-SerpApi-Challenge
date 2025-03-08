require 'google_search_results' 
require 'dotenv'
Dotenv.load
serp_api_api_key = ENV["SERPAPI_API_KEY"]

# to check if the environment variable is there. do NOT push this to production, espeically when there is logging.
puts "serp_api_api_key: #{serp_api_api_key}"

params = {
  api_key: serp_api_api_key,
  engine: "youtube",
  search_query:"ave mujica",
  q: "ave mujica"
}

search = GoogleSearch.new(params)
hash_results = search.get_hash

puts hash_results