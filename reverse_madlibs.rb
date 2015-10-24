# What is reverse madlibs?
# Ask user to provide a sentence 
# Save user sentence to the list of sentences.
# Or use suggested sentences.
# Randomise
# Process the sentence and replace instances.
# Print sentence.

# ---------------- METHODS -------------------
require 'pry'

# def say(msg)
#   puts "=> #{msg}"
# end

# def exit_with(msg)
#   say msg
#   exit
# end

def print_menu
  system 'clear'
  puts "Reverse Mad Libs".center(50, "---")
end

def get_words_from_file (file_name)
  unless File.exist?(file_name)
    say "#{file_name} doesn't exist!"
    return
  end

  File.open(file_name, "r" ) do |f|
    f.read
  end.split
end

def user_sentence
  puts "Your sentence".center(50, "---")
  puts """
  Where there's a noun or verb or adjective,
  replace it with NOUN, VERB or ADJECTIVE.

  For example: This is ADJECTIVE NOUN. 

  => Write down your sentence below:
  """
  sentence = STDIN.gets.chomp

end

def randomise_user_sentence(randomise, user_sentence)
  randomise(activate_file) 
end

def add_sentence_to_file(user_sentence)
  all_sentences = File.readlines("sentences.txt")
  unless all_sentences.include?("\n#{user_sentence}")
    File.open("sentences.txt", "a+") do |file|
      file << "\n#{user_sentence}"
    end
  end
end

def get_lines_from_file(file_name)
  if File.exist?(file_name)
    puts ("File doesn't exist!")  
    exit
  else
    File.open(file_name, "a+" ) do |file|
      file.readlines
    end
  end
end

def randomise(get_lines_from_file, nouns, verbs, adjectives)
  get_lines_from_file.gsub!("NOUN", nouns.sample)
  get_lines_from_file.gsub!("VERB", verbs.sample)
  get_lines_from_file.gsub!("ADJECTIVE", adjectives.sample)
end

# -------------- START PROGRAM -----------------

print_menu
file_name = ARGV[0]

nouns = get_words_from_file("nouns.txt")
verbs = get_words_from_file("verbs.txt")
adjectives = get_words_from_file("adjectives.txt")

loop do
  puts "Try your own sentence? (y/n) or (q)uit the program."
  response = STDIN.gets.chomp.downcase

  case response
  when "y"
    add_sentence_to_file(user_sentence)
    return randomise(get_lines_from_file(file_name), nouns, verbs, adjectives)
  when "n"
    return randomise(get_lines_from_file(file_name), nouns, verbs, adjectives)
  when "q"
    break
  end
end

puts randomise(get_lines_from_file(file_name), nouns, verbs, adjectives)




