#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
character = get_character_from_user
while character != "exit"
  if !get_character_list.include?(character)
    puts "Not found."
  else
    option = get_search_option
    while option != "movies" && option != "planet"
      puts "Try again!"
      option = get_search_option
    end
    if option == "movies"
      show_character_movies(character)
    else
      # home planet method here
      get_home_planet(character)
    end
  end
  character = get_character_from_user
end
