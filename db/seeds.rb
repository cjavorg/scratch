# Clear existing words
Word.delete_all

# Read words from file
word_file = File.join(File.dirname(__FILE__), 'word_list.txt')

File.readlines(word_file).each do |line|
  word = line.strip.downcase
  if word.length == 5
    Word.create!(text: word)
  end
end

puts "Created #{Word.count} words"