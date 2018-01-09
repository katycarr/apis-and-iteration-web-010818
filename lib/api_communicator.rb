require 'rest-client'
require 'json'
require 'pry'

def get_hash_from_api(url)
  info = RestClient.get(url)
  JSON.parse(info)
end

def get_character_movies_from_api(character)
  #make the web request
  # all_characters = RestClient.get('http://www.swapi.co/api/people/')
  # character_hash = JSON.parse(all_characters)

  character_hash = get_hash_from_api('http://www.swapi.co/api/people/')

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.


  found_character = character_hash["results"].find(ifnone = nil) do |character_info|
    character_info["name"].downcase == character
  end





if found_character
  movies = found_character["films"]


  films_hash = movies.map do |movie|
    # movie_info = RestClient.get(movie)
    # JSON.parse(movie_info)
    get_hash_from_api(movie)
  end


  films_hash

else
  puts "character not found"
end



end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list

  films_hash.each do |film|
    puts film["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  if films_hash
    parse_character_movies(films_hash)
  end
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
