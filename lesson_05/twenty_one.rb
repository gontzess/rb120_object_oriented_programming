## OO Twenty One Game program
class Card
  attr_reader :name

  def initialize(name, value, suit)
    @name = name
    @value = value
    @suit = suit
  end

  # def +(other_card)
  #   @value + other_card.value
  # end
  #
  # def -(other_card)
  #   @value - other_card.value
  # end

  def value(ace_low: false) ## need a way to know if Ace high or Ace low, orrr serve both?
    # return @value unless ace?
    # # ace_low ? @value[1] : @value[0]
    ace? ? @value[0] : @value
  end

  def ace?
    @name == 'Ace'
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
    shuffle
  end

  def top_card!
    @cards.shift
  end

  # def show ## REMOVE AFTER TESTING
  #   @cards.map(&:value)
  # end

  private

  def shuffle
    @cards.shuffle!
  end
end

class Participant
  def initialize
    @cards = []
  end

  def total ## need to add Ace high/low logic here
    raw_sum = @cards.map(&:value).sum #inject { |sum, card| sum + card.value }
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
    total > Game::CARD_LIMIT
  end

  private

  def not_busted?(num)
    num <= Game::CARD_LIMIT
  end
end

class Player < Participant
  # attr_reader :hand

  def cards
    @cards.map(&:name)
  end
end

class Dealer < Participant
  # def initialize(opponent_hand)
  #   super()
  #   @opponent_hand = opponent_hand
  # end

  def cards
    ["unknown card (#{@cards[0].name})"] + @cards[1..-1].map(&:name)
  end

  # def opponent_busted? ## refactor later
  #   @opponent_hand.sum > Game::CARD_LIMIT
  # end
end

class Game # / Table?
  CARD_LIMIT = 21
  ROUNDS_TO_WIN = 3

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new #(player.hand)
  end

  def play
    display_welcome_message
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn unless player.busted?
    show_results
    display_goodbye_message
  end

  private

  attr_reader :deck, :player, :dealer

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

  def display_welcome_message
    clear_screen
    puts "Welcome to Twenty One!"
    puts "You will be playing against the Dealer."
    puts "Get as close to #{CARD_LIMIT} as possible, without going over."
    puts "First to #{ROUNDS_TO_WIN} wins the game."
    puts ''
    puts "Ready? Press enter to begin."
    gets.chomp
    clear_screen
  end

  def display_goodbye_message
    puts "Press enter to exit."
    gets.chomp
    puts "Goodbye!"
    # sleep 3
    # clear_screen
  end

  def deal_cards
    2.times do
      player << deck.top_card!
      dealer << deck.top_card!
    end
  end

  def show_dealer_cards
    puts "Dealer has: #{joinor(dealer.cards)}. (#{dealer.total})"
  end

  def show_player_cards
    puts "You have: #{joinor(player.cards)}. (#{player.total})"
  end

  def show_initial_cards
    show_dealer_cards
    show_player_cards
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

  def player_turn
    puts "Your turn."
    loop do
      break if player.busted? || !player_hit?
      player << deck.top_card!
      puts "You hit!"
      show_player_cards
    end
    puts "You stayed at #{player.total}." unless player.busted?
  end

  def dealer_hit?
    return false if player.busted?
    dealer.total < player.total
  end

  def dealer_turn
    puts "Dealer's turn."
    loop do
      break if dealer.busted? || !dealer_hit?
      dealer << deck.top_card!
      puts "Dealer hits!"
      show_dealer_cards
    end
    puts "Dealer stayed at #{dealer.total}." unless dealer.busted?
  end

  def show_results
    if player.busted?
      puts "You busted at #{player.total}! Dealer wins!"
      return
    elsif dealer.busted?
      puts "Dealer busted at #{dealer.total}.. you win."
    else
      case player.total <=> dealer.total
      when -1 then puts "YOU LOSE. Dealer wins!"
      when 1 then puts "You win.. this time.."
      else puts "It's a tie."
      end
    end
  end
end

game = Game.new
game.play
