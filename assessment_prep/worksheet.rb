## worksheet

# ## using attr_accessor to create automatic getters and setter for name
# class Doggie
#   def initialize(name)
#     @name = name
#   end
#
#   def name
#     @name
#   end
#
#   def name=(new_name)
#     @name = new_name
#   end
# end
#
# spot = Doggie.new('Spot')
# spot.name   #=> Spot  ## using getter method for name
# spot.name = "Spotty"   ## using setter method for name
# spot.name   #=> Spotty  ## using getter method again for name

# class Person
#   def initialize
#   end
# end
#
# class Child
#   def initialize(name)
#     super()
#     @name = name
#   end
# end
#
#
# rickybobby = Person.new("Ricky Bobby")
# p rickybobby
#
# class Test
#   def self.square(b)
#     if b > 0
#       b * b
#     end
#   end
# end
#
# p Test.square(0)
# p Test.square(5)
#
#
module Armorable
  def attach_armor
    # implementation details
  end

  def remove_armor
    # implementation details
  end
end

module Castable
  def cast_spell(spell)
    # implementation details
  end
end

class RPGPlayer
  def initialize(name)
    @name = name
    @health = 100
    set_strength
    set_intelligence
  end

  def heal(change_in_health)
    @health += change_in_health
  end

  def hurt(change_in_health)
    @health -= change_in_health
  end

  def to_s
    "Name: #{@name}\n" + "Class: #{self.class}\n" + "Health: #{@health}\n" + "Strength: #{@strength}\n" + "Intelligence: #{@intelligence}\n"
  end

  # def puts
  #   # self.to_s.each { |attr| puts attr }
  #   ["Name: #{@name}", "Class: #{self.class}", "Health: #{@health}", "Strength: #{@strength}", "Intelligence: #{@intelligence}"].
  # end

  private

  def roll_dice
    rand(2..12)
  end

  def set_strength
    @strength = roll_dice
  end

  def set_intelligence
    @intelligence = roll_dice
  end
end

class Warrior < RPGPlayer
  include Armorable

  private

  def set_strength
    @strength = roll_dice + 2
  end
end

class Magicians < RPGPlayer
  include Castable

  private

  def set_intelligence
    @intelligence = roll_dice + 2
  end
end

class Paladin < RPGPlayer
  include Armorable
  include Castable
end

class Bard < Magicians
  ## assuming that Bards inherit all characteristics of a Magicians, but the problem details are vague about if `Bard`s receive the extra 2 points of intelligence.
  def create_potion
    # implementation details
  end
end

steve = Paladin.new("Steve")
puts steve

jasquier = Bard.new("Jasquier")
puts jasquier
