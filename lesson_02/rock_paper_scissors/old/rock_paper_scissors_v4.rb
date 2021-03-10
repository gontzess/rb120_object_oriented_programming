# OO Rock, Paper, Scissors game with Bonus Features
class Player
  attr_accessor :move, :name
  attr_reader :wins

  def initialize
    set_name
    @wins = 0
  end

  def won_round
    @wins += 1
  end

  def won_game?(max = RPSGame::ROUNDS_TO_WIN)
    @wins >= max
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
      puts "Please choose #{display_choices}:"
      choice = gets.chomp
      break if valid_choice?(choice)
      puts "Sorry, invalid entry."
    end
    self.move = Move.new(to_longhand(choice))
  end

  private

  ## MAKE CHOICE A NEW CLASS??
  def valid_choice?(choice)
    Move::VALUES.include?(choice) || Move::SHORTHAND_VALUES.include?(choice)
  end

  def to_longhand(choice)
    return nil if !valid_choice?(choice)
    return choice if Move::VALUES.include? choice

    idx = Move::SHORTHAND_VALUES.index(choice)
    Move::VALUES[idx]
  end

  def display_choices
    short = Move::SHORTHAND_VALUES.map { |str| "(#{str})" }
    Move::VALUES.zip(short).map(&:join).join(', ')
  end
end

class Computer < Player
  def set_name
    self.name = %w(R2D2 Chappie Sonny Bot).sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'spock', 'lizard']
  SHORTHAND_VALUES = ['r', 'p', 'sc', 'sp', 'l']
  WINNING_COMBOS = {'rock'=>['scissors', 'lizard'],
                    'paper'=>['rock', 'spock'],
                    'scissors'=>['paper', 'lizard'],
                    'spock'=>['scissors', 'rock'],
                    'lizard'=>['spock', 'paper']}

  attr_reader :hand

  def initialize(hand)
    @hand = hand
  end

  def to_s
    @hand
  end

  def <=>(other_move)
    other_hand = other_move.hand
    if hand == other_hand
      0
    elsif WINNING_COMBOS[hand].include? other_hand
      1
    elsif WINNING_COMBOS[other_hand].include? hand
      -1
    else
      nil
    end
  end
end

class RPSGame
  ROUNDS_TO_WIN = 3
  attr_accessor :human, :computer
  attr_reader :game_version

  def initialize
    @human = Human.new
    @computer = Computer.new
    @game_version = list_of_moves
  end

  def list_of_moves
    Move::VALUES.map(&:upcase).join(', ')
  end

  def display_welcome_message
    puts "Welcome to #{game_version}!"
  end

  def display_goodbye_message
    puts "Thanks for playing #{game_version}. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_round_winner
    case human.move <=> computer.move
    when -1
      computer.won_round
      puts "#{computer.name} won this round!"
    when 1
      human.won_round
      puts "#{human.name} won this round!"
    else
      puts "It's a tie this round!"
    end
  end

  def display_game_score
    puts "#{human.name}: #{human.wins}, #{computer.name}: #{computer.wins}"
  end

  def have_a_game_winner?
    human.won_game? || computer.won_game?
  end

  def display_game_winner
    case human.wins <=> computer.wins
    when -1
      puts "#{computer.name} won the game!"
    when 1
      puts "#{human.name} won this round!"
    else
      puts "Error, we tiredddd, we give up!"
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
      display_round_winner
      display_game_score
      if have_a_game_winner?
        display_game_winner
        break
      end
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
