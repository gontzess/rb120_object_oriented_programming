
class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

# exercise 1:
# teddy = Dog.new
# puts teddy.speak           # => "bark!"
# puts teddy.swim           # => "swimming!"
#
# jim = Bulldog.new
# puts jim.speak
# puts jim.swim

# exercise 2:
pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

p pete.run                # => "running!"
# p pete.speak              # => NoMethodError
p kitty.run               # => "running!"
p kitty.speak             # => "meow!"
# p kitty.fetch             # => NoMethodError
p dave.speak              # => "bark!"
p bud.run                 # => "running!"
p bud.swim                # => "can't swim!"

# exercise 4:
# What is the method lookup path and how is it important?
# SG: The method lookup path is the order in which ruby searches for a method when it is invoked on an object. Ruby starts with the object's class's methods first, then if it doesn't find the method it continues by checking for module mixins (if any), then if needed it searches the superclass, etc. This structure allows for objects to be grouped in a heirarchical structure where more general attributes and behaviors can be abstracted higher up and applied to several sub classes below without repeating code. It also allows us to create subclasses that only need to focus on the specialized attributes and behaviors.
