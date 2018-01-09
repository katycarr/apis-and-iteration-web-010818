require 'rest-client'
require 'json'
require 'pry'

def get_hash_from_api(url)
  info = RestClient.get(url)
  JSON.parse(info)
end

def character_hash
  character_info_array = []
  next_page = 'http://www.swapi.co/api/people/'
  while next_page
    page_hash = get_hash_from_api(next_page)
    next_page = page_hash["next"]
    page_hash["results"].each do |character_hash|
      character_info_array << character_hash
    end
  end
  character_info_array
end


def get_character_list
  list = []
  character_hash.each do |character_info|
    list << character_info["name"].downcase
  end
  list
end

def get_character_hash(character)
  character_hash.find do |character_info|
    character_info["name"].downcase == character
  end
end

def get_character_movies_from_api(character)
  found_character = get_character_hash(character)
  found_character["films"].map do |movie|
    get_hash_from_api(movie)
  end
end

def show_character_movies(character)
  puts "This characacter appears in:"
  get_character_movies_from_api(character).each do |film|
    puts film["title"]
  end
end

def get_home_planet(character)
  character_info = get_character_hash(character)
  home_planet_url = character_info["homeworld"]
  planet_name = get_hash_from_api(home_planet_url)["name"]
  puts "#{character} is from #{planet_name}"
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
