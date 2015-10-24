# What is reverse madlibs?
# Ask user to provide a sentence 
# Save user sentence to the list of sentences.
# Or use suggested sentences.
# Randomise
# Process the sentence and replace instances.
# Print sentence.

# ---------------- METHODS -------------------

def say(msg)
  puts "=> #{msg}"
end

def exit_with(msg)
  say msg
  exit
end

def print_menu
  system 'clear'
  puts "Reverse Mad Libs".center(40, "---")
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
  puts "Now it's your turn to try!".center(40, "---")
  puts """
Where there's a noun or verb or adjective,
replace it with NOUN, VERB or ADJECTIVE.

For example: This is ADJECTIVE NOUN. 

=> Write down your sentence below:
  """
  sentence = gets.chomp

end

def add_sentence_to_file(user_sentence)
  all_sentences = File.readlines(ARGV[0])
  unless all_sentences.include?("#{user_sentence}")
    File.open(ARGV[0], "a+") do |file|
      file << "#{user_sentence}"
    end
  end
end

def activate_file
  File.open(ARGV[0], "a+" ) do |file|
    file.read
  end
end

# -------------- START PROGRAM -----------------

print_menu

nouns = get_words_from_file("nouns.txt")
verbs = get_words_from_file("verbs.txt")
adjectives = get_words_from_file("adjectives.txt")

exit_with("No input file!") if ARGV.empty?
exit_with("File does't exist!") unless File.exist?(ARGV[0])

add_sentence_to_file(user_sentence)

loop do
  puts "Try your own sentence? (y/n) or (q)uit the program."
  response = gets.chomp.downcase
  case response
  when "y"
    add_sentence_to_file(user_sentence)
    activate_file
  when "n"
    activate_file
  when "q"
    break
  end
end

activate_file.gsub!("NOUN").each do
    nouns.sample 
  end

activate_file.gsub!("VERB").each do
  verbs.sample
end

activate_file.gsub!("ADJECTIVE").each do
  adjectives.sample
end

puts activate_file




