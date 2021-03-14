# We have a class such as the one below. Explain what the @@cats_count variable does and how it works. What code would you need to write to test your theory?

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# SG: the `@@cats_count` class variable keeps track of how many `Cat` objects are instantiated. Everytime a new `Cat` object is created, `@@cats_count` is increased by one. `self.cats_count` gives us class level getter method so we can read the value.

p Cat.cats_count #=> 0
fluffy = Cat.new('small')
p Cat.cats_count #=> 1
lazy = Cat.new('large')
p Cat.cats_count #=> 2
