
# ---------------- METHODS -------------------
require 'pry'
def print_menu
  system 'clear'
  puts "Reverse Mad Libs".center(50, "---")
end

def get_words_from_file(file_name)
  unless File.exist?(file_name)
    say "#{file_name} doesn't exist!"
    return
  end

  File.open(file_name, "r" ) do |f|
    f.read
  end.split
end

def user_sentence
  STDIN.gets.chomp
end

def add_sentence_to_file(user_sentence, file_name)
  all_sentences = File.readlines(file_name)
  unless all_sentences.include?("#{user_sentence}")
    File.open(file_name, "a+") do |file|
      file << "\n#{user_sentence}"
    end
  end
end

def get_lines_from_file(file_name)
  if File.exist?(file_name)
    File.open(file_name, "a+" ) do |file|
      file.readlines
    end
  else
    puts ("File doesn't exist!")  
    exit
  end
end

def randomise(sentences, nouns, verbs, adjectives)
  sentences.gsub!("NOUN", nouns.sample)
  sentences.gsub!("VERB", verbs.sample)
  sentences.gsub!("ADJECTIVE", adjectives.sample)
  sentences
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

  if response == "y"
    puts "Your sentence".center(50, "---")
    puts """
    Where there's a noun or verb or adjective,
    replace it with NOUN, VERB or ADJECTIVE.

    For example: This is ADJECTIVE NOUN. 

    => Write down your sentence below:
    """
    sentence = user_sentence
    add_sentence_to_file(sentence, file_name)
    puts randomise(sentence, nouns, verbs, adjectives)

  elsif response == "n"
    sentences = get_lines_from_file(file_name).sample
    puts randomise(sentences, nouns, verbs, adjectives)
  else response == "q"
    break
  end
end
