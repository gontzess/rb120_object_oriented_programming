class Animal
  attr_accessor :name

  def initialize(n)
    self.name = n
  end

  def speak
    "Hello"
  end
end

class GoodDog < Animal
  def initialize(c)
    super
    @color = c
  end

  def speak
    # "#{self.name} says arf!"
    super + " from the GoodDog class"
  end
end

class BadDog < Animal
  def initialize(age, name)
    super(name)
    @age = age
  end
end

class Cat < Animal
end

# sparky = GoodDog.new("Sparky")
# paws = Cat.new
#
# puts sparky.speak
# puts paws.speak

bruno = GoodDog.new("brown")
p bruno

p BadDog.new(2, "bear")
