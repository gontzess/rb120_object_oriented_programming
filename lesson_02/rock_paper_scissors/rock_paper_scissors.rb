# OO Rock, Paper, Scissors game
class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    n = nil
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, invalid entry."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid entry."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = %w(R2D2 Chappie Sonny Number_5).sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors']

  attr_reader :hand

  def initialize(hand)
    @hand = hand
  end

  def rock?
    @hand == 'rock'
  end

  def paper?
    @hand == 'paper'
  end

  def scissors?
    @hand == 'scissors'
  end

  def <=>(other_move)
    return 0 if hand == other_move.hand
    
    if rock?
      return -1 if other_move.paper?
      return 1 if other_move.scissors?
    elsif paper?
      return -1 if other_move.scissors?
      return 1 if other_move.rock?
    elsif scissors?
      return -1 if other_move.rock?
      return 1 if other_move.paper?
    end
    nil
  end

  def to_s
    @hand
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    case human.move <=> computer.move
    when -1 then puts "#{computer.name} won!"
    when 1  then puts "#{human.name} won!"
    else         puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if %w(y n).include? answer.downcase
      puts "Sorry, invalid entry."
    end
    answer == 'y'
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
