# OO Rock, Paper, Scissors game with Bonus Features
module Formattable
  def puts(message)
    super("=> #{message}")
  end

  def clear_screen
    (system 'clear') || (system 'cls')
  end
end

class Player
  include Formattable

  attr_accessor :name, :move
  attr_reader :wins

  def initialize
    set_name
    @wins = 0
    @move_history = []
  end

  def to_s
    @name
  end

  def won_round
    @wins += 1
  end

  def won_game?(max = RPSGame::ROUNDS_TO_WIN)
    @wins >= max
  end

  def move_history
    @move_history.join(', ')
  end

  def save_last_move
    @move_history << move if !!move
    nil
  end

  def reset
    @wins = 0
    @move_history = []
    @move = nil
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
      puts "Please choose #{Move.display_choices}:"
      choice = gets.chomp.downcase
      break if Move.valid?(choice)
      puts "Sorry, invalid entry."
    end
    choice = Move.longhand(choice)
    self.move = Move.new(choice) # .to_longhand!
  end
end

class Computer < Player
  NAMES = ['Bot', 'R2D2', 'Sonny', 'Hal']
  TENDENCIES = { 'Bot' => ['rock', 'paper', 'scissors', 'spock', 'lizard'],
                 'R2D2' => ['scissors', 'scissors', 'scissors', 'rock', 'spock',
                            'lizard'],
                 'Sonny' => ['rock'],
                 'Hal' => ['rock', 'paper', 'scissors'] }

  attr_reader :tendency

  def initialize
    super
    set_tendency
  end

  def set_name
    self.name = NAMES.sample
  end

  def set_tendency
    @tendency = TENDENCIES[name]
  end

  def choose
    self.move = Move.new(tendency.sample)
  end
end

class Move
  HANDS = ['rock', 'paper', 'scissors', 'spock', 'lizard']
  SHORT_HANDS = { 'r' => 'rock', 'p' => 'paper', 'sc' => 'scissors',
                  'sp' => 'spock', 'l' => 'lizard' }
  WINNING_COMBOS = { 'rock' => ['scissors', 'lizard'],
                     'paper' => ['rock', 'spock'],
                     'scissors' => ['paper', 'lizard'],
                     'spock' => ['scissors', 'rock'],
                     'lizard' => ['spock', 'paper'] }

  attr_reader :hand # , :winning_combo

  def initialize(hand)
    @hand = hand
    # set_winning_combo
  end

  def <=>(other_move)
    other_hand = other_move.hand
    return 0 if hand == other_hand
    return 1 if WINNING_COMBOS[hand].include?(other_hand)
    return -1 if WINNING_COMBOS[other_hand].include?(hand)
    nil
  end

  # def set_winning_combo
  #   @winning_combo = WINNING_COMBOS[@hand]
  # end
  #
  # def <=>(other_move)
  #   other_hand = other_move.hand
  #   if hand == other_hand
  #     0
  #   elsif @winning_combo.include?(other_hand)
  #     1
  #   elsif other_move.winning_combo.include?(hand)
  #     -1
  #   else
  #     nil
  #   end
  # end

  def to_s
    @hand
  end

  def self.valid?(choice)
    HANDS.include?(choice) || SHORT_HANDS.keys.include?(choice)
  end

  def self.longhand(choice)
    return nil if !valid?(choice)

    if SHORT_HANDS.keys.include?(choice)
      return SHORT_HANDS[choice]
    end

    choice
  end

  def to_longhand!
    return nil if !valid?(@hand)

    if SHORT_HANDS.keys.include?(@hand)
      @hand = SHORT_HANDS[@hand]
    end

    self
  end

  def self.display_choices
    SHORT_HANDS.map { |short, long| "#{long}(#{short})" }.join(', ')
  end
end

class RPSGame
  include Formattable

  ROUNDS_TO_WIN = 3

  def initialize
    clear_screen
    @human = Human.new
    @computer = Computer.new
    @game_version = list_of_moves
  end

  # rubocop:disable Metrics/MethodLength
  def play
    loop do
      clear_screen
      display_welcome_message
      loop do
        player_turns
        display_round_results
        break if a_game_winner?
      end
      display_game_results
      break unless play_again?
      reset_game
    end
    display_goodbye_message
  end
  # rubocop:enable Metrics/MethodLength

  private

  attr_accessor :human, :computer
  attr_reader :game_version

  def list_of_moves
    Move::HANDS.map(&:upcase).join(', ')
  end

  def display_welcome_message
    puts "Welcome to #{game_version}!"
    puts "First to #{ROUNDS_TO_WIN} rounds wins!"
  end

  def display_goodbye_message
    puts "Thanks for playing #{game_version}. Good bye!"
  end

  def player_turns
    human.choose
    human.save_last_move
    computer.choose
    computer.save_last_move
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

  def display_round_results
    display_moves
    display_round_winner
    display_game_score
  end

  def display_game_score
    puts "The score is #{human.name}: #{human.wins}, " \
         "#{computer.name}: #{computer.wins}"
  end

  def a_game_winner?
    human.won_game? || computer.won_game?
  end

  def display_game_winner
    case human.wins <=> computer.wins
    when -1
      puts "#{computer.name} won the game!"
    when 1
      puts "#{human.name} won the game!"
    else
      puts "Error, we tiredddd, we give up!"
    end
  end

  def display_move_history
    puts "Game Summary:"
    puts "#{human.name} played: #{human.move_history}."
    puts "#{computer.name} played: #{computer.move_history}."
  end

  def display_game_results
    display_game_winner
    display_move_history
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n yes no).include? answer
      puts "Sorry, invalid entry."
    end
    answer == 'y' || answer == 'yes'
  end

  def reset_game
    human.reset
    computer.reset
  end
end

RPSGame.new.play
