require 'rest-client'
require 'json'
require 'pry'

def get_hash_from_api
  character_info_array = []
  next_page = 'http://www.swapi.co/api/people/'
  while next_page
    info = RestClient.get(next_page)
    page_hash = JSON.parse(info)
    next_page = page_hash["next"]
    page_hash["results"].each do |character_hash|
      character_info_array << character_hash
    end
    character_info_array
  end
  character_info_array

end


def get_character_list
  character_hash = get_hash_from_api
  list = []
  character_hash.each do |character_info|
    list << character_info["name"].downcase
  end
  list
end

def get_character_hash(character)
  character_hash = get_hash_from_api
  character_hash.find(ifnone = nil) do |character_info|
    character_info["name"].downcase == character
  end
end

def get_character_movies_from_api(character)
  found_character = get_character_hash(character)

  movies = found_character["films"]

  films_hash = movies.map do |movie|
    movies = RestClient.get(movie)
    JSON.parse(movies)
  end

  films_hash

end

def parse_character_movies(films_hash)
  films_hash.each do |film|
    puts film["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  if films_hash
    parse_character_movies(films_hash)
  else
    puts "Character not found."
  end
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
