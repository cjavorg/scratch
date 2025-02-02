class Game < ActiveRecord::Base
  belongs_to :word
  serialize :guesses

  validates :word, presence: true

  def check_guess(guess)
    raise ArgumentError, "Guess cannot be nil" if guess.nil?
    raise ArgumentError, "Guess must be 5 letters" unless guess.length == 5

    target = word.text
    result = Array.new(5)

    # Create a hash to track remaining letters for partial matches
    remaining_letters = target.chars.tally

    # First pass: Mark exact matches and update remaining letters
    guess.chars.each_with_index do |char, i|
      if char == target[i]
        result[i] = :correct
        remaining_letters[char] -= 1
      end
    end

    # Second pass: Mark partial matches and incorrect letters
    guess.chars.each_with_index do |char, i|
      next if result[i] == :correct

      if remaining_letters[char].to_i > 0
        result[i] = :partial
        remaining_letters[char] -= 1
      else
        result[i] = :incorrect
      end
    end

    result
  end
end
