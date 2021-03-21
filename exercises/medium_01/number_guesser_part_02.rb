class GuessingGame

  def initialize(low, high)
    @range = (low..high).freeze
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
    @number = rand(@range)
    @guesses = Math.log2(@range.size).to_i + 1
    @won = false
  end

  def guess_number
    choice = nil
    loop do
      print "Enter a number between #{@range.first} and #{@range.last}: "
      choice = gets.chomp.to_i
      break if (@range).include?(choice)
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


game = GuessingGame.new(501, 1500)
game.play
game.play
