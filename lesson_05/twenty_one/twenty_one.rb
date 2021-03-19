## Twenty One Game OO program
module Formattable
  def clear_screen
    (system 'clear') || (system 'cls')
  end

  def joinor(ary, divider=', ', ending='and')
    case ary.length
    when 0 then ''
    when 1 then ary.first.to_s
    when 2 then ary.join(" #{ending} ")
    else
      ary[0..-2].join(divider) + "#{divider}#{ending} #{ary.last}"
    end
  end

  def puts(message)
    message == '' ? super : super("=> #{message}")
  end
end

class Card
  attr_reader :name

  def initialize(name, value, suit)
    @name = name
    @value = value
    @suit = suit
  end

  ## would need a way to know if Ace high or Ace low, orrr serve both?
  # def value(ace_low: false)
  #   return @value unless ace?
  #   ace_low ? @value[1] : @value[0]
  # end

  def value
    ace? ? @value[0] : @value
  end

  def ace?
    @name == 'Ace'
  end

  def to_s
    "#{@name} of #{@suit}"
  end
end

class Deck
  CARD_NAMES = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)
  CARD_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, [11, 1]]
  CARD_SUITS = %w(Hearts Diamonds Clubs Spades)

  def initialize
    reset
  end

  def reset
    @cards = []
    (1..52).each do |card_id|
      @cards << Card.new(CARD_NAMES[(card_id % 13) - 1],
                         CARD_VALUES[(card_id % 13) - 1],
                         CARD_SUITS[(card_id - 1) / 13])
    end
    shuffle!
  end

  def deal_top_card!
    @cards.shift
  end

  private

  def shuffle!
    @cards.shuffle!
  end
end

class Participant
  include Formattable

  attr_reader :name, :wins

  def initialize
    reset_cards
    set_name
    @wins = 0
  end

  def reset_cards
    @cards = []
  end

  def won_round
    @wins += 1
  end

  def won_game?(max = TwentyOne::ROUNDS_TO_WIN)
    @wins >= max
  end

  def total
    raw_sum = @cards.map(&:value).sum
    return raw_sum if not_busted?(raw_sum)

    aces = @cards.select(&:ace?).size

    loop do
      return raw_sum if aces.zero? || not_busted?(raw_sum)

      raw_sum -= 10
      aces -= 1
    end
  end

  def <<(new_card)
    @cards << new_card
  end

  def busted?
    total > TwentyOne::CARD_LIMIT
  end

  private

  def not_busted?(num)
    num <= TwentyOne::CARD_LIMIT
  end
end

class Player < Participant
  def show_cards
    puts ""
    puts "---- #{@name}'s Hand ----"
    cards.each { |card| puts card }
    puts "Total: #{total}"
    puts ""
  end

  private

  def set_name
    n = nil
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "That's not a valid choice."
    end
    @name = n
  end

  def cards
    @cards.map(&:to_s)
  end
end

class Dealer < Participant
  def show_cards
    puts ""
    puts "---- #{@name}'s Hand ----"
    cards.each { |card| puts card }
    puts ""
  end

  private

  def set_name
    @name = ['Bot', 'R2D2', 'Sonny', 'Hal'].sample
  end

  def cards
    hand = @cards.map(&:to_s)
    hand[1] = "unknown card"
    hand
  end
end

class TwentyOne
  include Formattable

  CARD_LIMIT = 21
  ROUNDS_TO_WIN = 3

  def initialize
    display_welcome_message
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
    @round = 1
  end

  # rubocop:disable Metrics/MethodLength
  def play
    display_rules_message
    loop do
      deal_cards
      show_initial_cards
      player_turn
      dealer_turn unless player.busted?
      display_round_results
      display_game_score
      break if someone_won_game? || !continue_to_next_round?
      reset
    end
    display_game_results if someone_won_game?
    display_goodbye_message
  end
  # rubocop:enable Metrics/MethodLength

  private

  attr_reader :deck, :player, :dealer

  def display_welcome_message
    clear_screen
    puts "Welcome to Twenty One!"
  end

  def display_rules_message
    puts ""
    puts "Welcome #{player.name}!"
    puts "#{dealer.name} will be your dealer (and opponent) today."
    puts "Get as close to #{CARD_LIMIT} as possible, without going over."
    puts "First to #{ROUNDS_TO_WIN} wins the game."
    puts ""
    puts "Ready? Press enter to begin."
    gets.chomp
    clear_screen
  end

  def display_goodbye_message
    puts "Press enter to exit."
    gets.chomp
    puts "Remember.. no sore losers!"
    puts "Goodbye!"
    sleep 3
    clear_screen
  end

  def deal_cards
    2.times do
      player << deck.deal_top_card!
      dealer << deck.deal_top_card!
    end
  end

  def show_initial_cards
    puts "Round #{@round}."
    dealer.show_cards
    player.show_cards
  end

  def player_hit?
    answer = ''
    puts "Hit or stay? (h/s)"
    loop do
      answer = gets.chomp.downcase
      break if %w(h s).include?(answer)
      puts "That's not a valid choice."
    end
    answer == 'h'
  end

  def dealer_hit?
    return false if player.busted?
    dealer.total < player.total
  end

  def hits?(person)
    case person
    when player then player_hit?
    when dealer then dealer_hit?
    end
  end

  def turn!(person)
    loop do
      break if person.busted? || !hits?(person)
      person << deck.deal_top_card!
      puts "#{person.name} hits!"
      person.show_cards
    end
    puts "#{person.name} stayed at #{person.total}." unless person.busted?
  end

  def player_turn
    puts "Your turn."
    turn!(player)
    puts ""
  end

  def dealer_turn
    puts "Dealer's turn."
    turn!(dealer)
    puts ""
  end

  def dealer_won_round(opponent_busted: false)
    dealer.won_round
    if opponent_busted
      puts "#{player.name} busted at #{player.total}! #{dealer.name} wins!"
    else
      puts "#{player.name} LOSES. #{dealer.name} wins!"
    end
  end

  def player_won_round(opponent_busted: false)
    player.won_round
    if opponent_busted
      puts "#{dealer.name} busted at #{dealer.total}.. #{player.name} wins."
    else
      puts "#{player.name} wins.. this time.."
    end
  end

  def compare_cards
    case player.total <=> dealer.total
    when -1
      dealer_won_round
    when 1
      player_won_round
    else
      puts "It's a tie."
    end
  end

  def display_round_results
    return dealer_won_round(opponent_busted: true) if player.busted?
    return player_won_round(opponent_busted: true) if dealer.busted?
    compare_cards
  end

  def reset
    @round += 1
    deck.reset
    player.reset_cards
    dealer.reset_cards
    clear_screen
  end

  def display_game_score
    puts ""
    puts "Score:"
    puts "#{player.name}: #{player.wins}, #{dealer.name}: #{dealer.wins}."
  end

  def someone_won_game?
    player.won_game? || dealer.won_game?
  end

  def continue_to_next_round?
    answer = nil
    loop do
      puts "Continue to the next round? (y or n)"
      answer = gets.chomp.downcase
      break if %w(y n yes no).include?(answer)
      puts "That's not a valid choice."
    end
    answer == 'y' || answer == 'yes'
  end

  def display_game_results
    case player.wins <=> dealer.wins
    when 1  then puts "#{player.name} wins the game.."
    when -1 then puts "#{dealer.name} WINS the game!"
    else         puts "Error, we tiredddd, we give up!"
    end
  end
end

game = TwentyOne.new
game.play
