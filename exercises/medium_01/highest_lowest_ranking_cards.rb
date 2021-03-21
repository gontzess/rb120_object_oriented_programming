# Update this class so you can use it to determine the lowest ranking and highest ranking cards in an Array of Card objects:

class Card
  include Comparable
  PRIVILEGE = { 'Jack' => 1, 'Queen' => 2, 'King' => 3, 'Ace' => 4 }
  FEUDAL_LOYALTY = { 'Diamonds' => 1, 'Clubs' => 2, 'Hearts' => 3, 'Spades' => 4 }

  attr_reader :rank, :suit, :relative_value, :suit_tie_breaker

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    set_relative_value
    set_suit_tie_breaker
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def <=>(other_card)
    return tie_breaker(other_card) if same_suit?(other_card)
    @relative_value <=> other_card.relative_value
  end

  private

  def royalty?
    !@rank.is_a?(Integer)
  end

  def set_relative_value
    @relative_value = royalty? ? 10 + PRIVILEGE[rank] : rank
  end

  def set_suit_tie_breaker
    @suit_tie_breaker = FEUDAL_LOYALTY[suit]
  end

  def tie_breaker(other_card)
    @suit_tie_breaker <=> other_card.suit_tie_breaker
  end

  def same_suit?(other_card)
    @suit == other_card.suit
  end
end


cards = [Card.new(2, 'Hearts'),
         Card.new(10, 'Diamonds'),
         Card.new('Ace', 'Clubs')]
puts cards
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
         Card.new(4, 'Diamonds'),
         Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
         Card.new('Jack', 'Diamonds'),
         Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min.rank == 8
puts cards.max.rank == 8

cards = [Card.new(4, 'Hearts'),
         Card.new(4, 'Diamonds'),
         Card.new(10, 'Clubs')]
puts cards.min == Card.new(4, 'Diamonds')
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min == Card.new(8, 'Diamonds')
puts cards.max == Card.new(8, 'Spades')
