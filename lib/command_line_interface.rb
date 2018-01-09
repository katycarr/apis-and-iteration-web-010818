def welcome
  # puts out a welcome message here!
  puts "Welcome! The Force is strong with you."
end

def get_character_from_user
  puts "Please enter a character or 'exit' to quit."
  gets.downcase.chomp

  # use gets to capture the user's input. This method should return that input, downcased.
end
