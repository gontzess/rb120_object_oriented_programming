# Create an object-oriented number guessing class for numbers in the range 1 to 100, with a limit of 7 guesses per game. The game should play like below. Note that a game object should start a new game with a new number to guess with each call to #play.

class GuessingGame
  RANGE = (1..100)

  def initialize
    @number = nil
    @guesses = nil
    @won = nil
  end

  def play
    reset
    loop do
      puts "You have #{guesses} guesses remaining."
      choice = guess_number
      high_low(choice)
      puts ""
      break if won? || out_of_guesses?
    end
    won? ? (puts "You won!") : (puts "You have no more guesses. You lost!")
    puts ""
  end

  private

  attr_reader :guesses

  def reset
    @number = rand(RANGE)
    @guesses = 7
    @won = false
  end

  def guess_number
    choice = nil
    loop do
      print "Enter a number between #{RANGE.first} and #{RANGE.last}: "
      choice = gets.chomp.to_i
      break if (RANGE).include?(choice)
      print "Invalid guess. "
    end
    choice
  end

  def high_low(choice)
    @guesses -= 1
    case @number <=> choice
    when -1
      puts "Your guess is too high."
    when 0
      puts "That's the number!"
      @won = true
    when 1
      puts "Your guess is too low."
    end
  end

  def out_of_guesses?
    @guesses <= 0
  end

  def won?
    @won == true
  end
end


game = GuessingGame.new
game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low.
#
# You have 6 guesses remaining.
# Enter a number between 1 and 100: 75
# Your guess is too low.
#
# You have 5 guesses remaining.
# Enter a number between 1 and 100: 85
# Your guess is too high.
#
# You have 4 guesses remaining.
# Enter a number between 1 and 100: 0
# Invalid guess. Enter a number between 1 and 100: 80
#
# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# That's the number!
#
# You won!

game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 50
# Your guess is too high.
#
# You have 6 guesses remaining.
# Enter a number between 1 and 100: 25
# Your guess is too low.
#
# You have 5 guesses remaining.
# Enter a number between 1 and 100: 37
# Your guess is too high.
#
# You have 4 guesses remaining.
# Enter a number between 1 and 100: 31
# Your guess is too low.
#
# You have 3 guesses remaining.
# Enter a number between 1 and 100: 34
# Your guess is too high.
#
# You have 2 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.
#
# You have 1 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.
#
# You have no more guesses. You lost!
