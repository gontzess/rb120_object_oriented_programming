# In the previous two exercises, you developed a Card class and a Deck class. You are now going to use those classes to create and evaluate poker hands. Create a class, PokerHand, that takes 5 cards from a Deck of Cards and evaluates those cards as a Poker hand.

class Card
  include Comparable
  PRIVILEGE = { 'Jack' => 1, 'Queen' => 2, 'King' => 3, 'Ace' => 4 }.freeze
  FEUDAL_LOYALTY = { 'Diamonds' => 1, 'Clubs' => 2, 'Hearts' => 3, 'Spades' => 4 }.freeze

  attr_reader :rank, :suit, :relative_value

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    set_relative_value
    # set_suit_tie_breaker
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def <=>(other_card)
    # return tie_breaker(other_card) if @suit == other_card.suit
    @relative_value <=> other_card.relative_value
  end

  def royalty?
    !@rank.is_a?(Integer)
  end

  protected

  attr_reader :suit_tie_breaker

  # def same_suit?(other_card)
  #   @suit == other_card.suit
  # end

  private

  def set_relative_value
    @relative_value = royalty? ? 10 + PRIVILEGE[rank] : rank
  end

  # def set_suit_tie_breaker
  #   @suit_tie_breaker = FEUDAL_LOYALTY[suit]
  # end

  # def tie_breaker(other_card)
  #   @suit_tie_breaker <=> other_card.suit_tie_breaker
  # end

  # def consecutive?(other_card)
  #   abs(@relative_value - other_card.relative_value) == 1
  # end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @cards = []
    reset
  end

  def draw
    reset if @cards.empty?
    @cards.shift
  end

  private

  def reset
    (1..52).each do |card_id|
      @cards << Card.new(RANKS[(card_id % 13) - 1], SUITS[(card_id - 1) / 13])
    end
    @cards.shuffle!
  end
end

class PokerHand
  def initialize(deck)
    @deck = deck
    @hand = []
    deal_hand
  end

  def print
    @hand.each { |card| puts card }
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  attr_reader :deck

  def deal_hand
    5.times do
      @hand << @deck.draw
    end
  end

  def royal_flush?
    # straight_flush? && @hand.min.rank == 10
    # flush? && @hand.select(&:royalty?).size == 4 &&
    #   @hand.map(&:rank).include?(10)
    # straight_flush? && @hand.map(&:relative_value).sort.first == 10
    straight_flush? && @hand.min.rank == 10
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    @hand.map(&:rank).tally.has_value?(4)
  end

  def full_house?
    pair? && three_of_a_kind?
  end

  def flush?
    # first_suit = @hand.first.suit
    # @hand.all? { |card| card.suit == first_suit }
    @hand.map(&:suit).uniq.size == 1
  end

  def straight?
    values = @hand.map(&:relative_value).sort
    consecutive = values.first.step.take(5)
    values == consecutive
  end

  def three_of_a_kind?
    @hand.map(&:rank).tally.has_value?(3)
  end

  def two_pair?
    @hand.map(&:rank).tally.values.count(2) == 2
  end

  def pair?
    @hand.map(&:rank).tally.has_value?(2)
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate
puts ""

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts 'Royal flush'
puts hand.evaluate
puts hand.evaluate == 'Royal flush'
puts ""

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts 'Straight flush'
puts hand.evaluate
puts hand.evaluate == 'Straight flush'
puts ""

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts 'Four of a kind'
puts hand.evaluate
puts hand.evaluate == 'Four of a kind'
puts ""

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts 'Full house'
puts hand.evaluate
puts hand.evaluate == 'Full house'
puts ""

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts 'Flush'
puts hand.evaluate
puts hand.evaluate == 'Flush'
puts ""

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts 'Straight'
puts hand.evaluate
puts hand.evaluate == 'Straight'
puts ""

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts 'Straight'
puts hand.evaluate
puts hand.evaluate == 'Straight'
puts ""

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts 'Three of a kind'
puts hand.evaluate
puts hand.evaluate == 'Three of a kind'
puts ""

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts 'Two pair'
puts hand.evaluate
puts hand.evaluate == 'Two pair'
puts ""

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts 'Pair'
puts hand.evaluate
puts hand.evaluate == 'Pair'
puts ""

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts 'High card'
puts hand.evaluate
puts hand.evaluate == 'High card'
puts ""
