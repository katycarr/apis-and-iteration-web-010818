#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
character = get_character_from_user
while character != "exit"
  if !get_character_list.include?(character)
    puts "Not found."
  else
    show_character_movies(character)
  end
  character = get_character_from_user
end
