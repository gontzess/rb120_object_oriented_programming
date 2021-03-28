### Practice Problems / Questions

#### OOP Book & Lessons
1. What is OOP? List all the benefits of OOP?
2. What is encapsulation? How is this achieved in Ruby?
3. What is polymorphism? What are the different ways to apply polymorphism in Ruby?
4. What is duck typing?
5. What is class inheritance? How does this work in Ruby?
6. What is an object? What is a `Class`? What is a `Module`?
7. What are the differences between classes and modules? How do you decide which to use?
8. What is instantiation? Provide an example.
9. What is the method lookup path? How is it important?
10. How do we create an object in Ruby? Give an example of the creation of an object.
11. What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created above and include it properly.
12. What is a constructor? Provide an example.
13. What is an instance variable? Provide an example.
14. What is an instance method? Provide an example.
15. What are getter and setter methods? Provide an example.
16. What are accessor methods? Provide an example.
17. What are class methods? Provide an example.
18. What are class variables? Provide an example.
19. What are constant variables? Provide an example.
20. What's the difference between instance and class variables?
21. What's the difference between instance and class methods?
22. Why do custom classes usually define a `to_s` method?
23. What is class inheritance? Provide an example.
24. What is method overriding? Provide an example.
25. When are Modules used? What is interface inheritance? What is multiple inheritance?
26. What is namespacing? When is using namespacing beneficial?
27. What is method access control?
28. How are encapsulation and method access control related?
29. What are the differences between public, private, and protected methods?
30. What are collaborator objects? Why are they important in OOP?
31. [Lesson 3](https://launchschool.com/lessons/d2f05460/assignments)
    - Equivalence
    - Variable scope
    - Inheritance and variable scope
      - Constant lookup path, lexical scope
    - Fake operators
    - Exceptions
    - Truthiness?

#### Explain this code / what is this an example of / what is outputted?
ex 1
```ruby
class GoodDog
end

sparky = GoodDog.new
```
ex 2
```ruby
module Speak
  def speak(sound)
    puts sound
  end
end

class GoodDog
  include Speak
end

class HumanBeing
  include Speak
end

sparky = GoodDog.new
sparky.speak("Arf!")   # => ?
bob = HumanBeing.new
bob.speak("Hello!")   # => ?
```
ex 3, also what will the code output?
```ruby
module Speak
  def speak(sound)
    puts "#{sound}"
  end
end

class GoodDog
  include Speak
end

class HumanBeing
  include Speak
end

puts GoodDog.ancestors   # => ?
puts HumanBeing.ancestors   # => ?
```
ex 4
```ruby
class GoodDog
  def initialize
    puts "This object was initialized!"
  end
end

sparky = GoodDog.new   # => ?
```
ex 4
```ruby
class GoodDog
  def initialize(name)
    @name = name
  end
end

sparky = GoodDog.new("Sparky")
```
ex 5
```ruby
class GoodDog
  def initialize(name)
    @name = name
  end

  def speak
    "Arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak   # => ?
fido = GoodDog.new("Fido")
puts fido.speak   # => ?
```
ex 6
```ruby
class GoodDog
  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak   # => ?
fido = GoodDog.new("Fido")
puts fido.speak   # => ?
```
ex 7
```ruby
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak   # => ?
puts sparky.name   # => ?
sparky.name = "Spartacus"
puts sparky.name   # => ?
```
ex 8, what is the difference between the two?
```ruby
def speak
  "#{@name} says arf!"
end

def speak
  "#{name} says arf!"
end
```
ex 9
```ruby
def change_info(n, h, w)
  self.name = n
  self.height = h
  self.weight = w
end
```
ex 10
```ruby
# ... rest of code ommitted for brevity

def self.what_am_i
  "I'm a GoodDog class!"
end

GoodDog.what_am_i   # => ?
```
ex 11
```ruby
class GoodDog
  @@number_of_dogs = 0

  def initialize
    @@number_of_dogs += 1
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end
end

puts GoodDog.total_number_of_dogs   # => ?

dog1 = GoodDog.new
dog2 = GoodDog.new

puts GoodDog.total_number_of_dogs   # => ?
```
ex 12
```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age  = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
puts sparky.age             # => ?
```
ex 13
```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    @name = n
    @age  = a * DOG_YEARS
  end

  def to_s
    "This dog's name is #{name} and it is #{age} in dog years."
  end
end

puts sparky      # => ?
```
ex 14 , what do the different `self`s refer to?
```ruby
class GoodDog
  # ... rest of code omitted for brevity

  def what_is_self
    self
  end

  def self.this_is_a_class_method
  end

  puts self
end
```
ex 15
```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
end

class Cat < Animal
end

sparky = GoodDog.new
paws = Cat.new
puts sparky.speak           # => ?
puts paws.speak             # => ?
```
ex 16
```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  attr_accessor :name

  def initialize(n)
    self.name = n
  end

  def speak
    "#{self.name} says arf!"
  end
end

class Cat < Animal
end

sparky = GoodDog.new("Sparky")
paws = Cat.new

puts sparky.speak           # => ?
puts paws.speak             # => ?
```
ex 17
```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  def speak
    super + " from GoodDog class"
  end
end

sparky = GoodDog.new
sparky.speak        # => ?
```
ex 18
```ruby
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class BadDog < Animal
  def initialize(age, name)
    super(name)
    @age = age
  end
end

BadDog.new(2, "bear")    # => #<BadDog:0x007fb40b2beb68 @age=2, @name="bear">
```
ex 19
```ruby
module Swimmable
  def swim
    "I'm swimming!"
  end
end

class Animal; end

class Fish < Animal
  include Swimmable
end

class Mammal < Animal
end

class Cat < Mammal
end

class Dog < Mammal
  include Swimmable
end

sparky = Dog.new
neemo  = Fish.new
paws   = Cat.new

sparky.swim                 # => ?
neemo.swim                  # => ?
paws.swim                   # => ?
```
ex 20
```ruby
module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end

puts Animal.ancestors    # => ?
```
ex 21
```ruby

class Animal
  include Walkable
end

class GoodDog < Animal
  include Swimmable
  include Climbable
end

puts GoodDog.ancestors    # => ?
```
ex 22
```ruby
module Mammal
  class Dog
    def speak(sound)
      p "#{sound}"
    end
  end

  class Cat
    def say_name(name)
      p "#{name}"
    end
  end
end
```
ex 23
```ruby
class Animal
  def a_public_method
    "Will this work? " + self.a_protected_method
  end

  protected

  def a_protected_method
    "IDK, I'm protected!"
  end
end

fido = Animal.new
fido.a_public_method        # => ?
```
ex 24
```ruby
class Wedding
  attr_reader :guests, :flowers, :songs

  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_wedding(self)
    end
  end
end

class Chef
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end

  def prepare_food(guests)
    #implementation
  end
end

class Decorator
  def prepare_wedding(wedding)
    decorate_place(wedding.flowers)
  end

  def decorate_place(flowers)
    # implementation
  end
end

class Musician
  def prepare_wedding(wedding)
    prepare_performance(wedding.songs)
  end

  def prepare_performance(songs)
    #implementation
  end
end
```
ex 25
```ruby
class Person
  attr_accessor :name, :pet

  def initialize(name)
    @name = name
  end
end

bob = Person.new("Robert")
bud = Bulldog.new             # assume Bulldog class from previous assignment

bob.pet = bud
bob.pet.fetch                 # => "fetching!"
```
