# What output does this code print? Fix this class so that there are no surprises waiting in store for the unsuspecting developer.

class Pet
  attr_reader :name

  def initialize(name)
    @name = name#.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
# puts fluffy
puts fluffy.name
puts name

# FURTHER EXPLORATION: What would happen in this case?
puts "____"
name = 42
fluffy = Pet.new(name)
name += 1
p fluffy.name
# puts fluffy
p fluffy.name
p name
# SG: The reason `fluffy.name` still returns `"42"` is because the instance variable `@name` and the local variable `name` point to different objects by the end. The `+=` that occurs in `name += 1` reassigns the local variable `name` to reference a new object (the integer `43`). Meanwhile the instance variable `@name` continues to references the object it was initialized to, the string `'42'` (which was the return value of `42.to_s`). Even if we removed the `to_s` method call in the `initialize` method, so that `@name` is initialized to the integer `42`, we still know that the local variable `name` will be reassigned with `+=`.

puts "____"
name = "Fred"
fluffy = Pet.new(name)
name << "bob"
p fluffy.name
# puts fluffy
p fluffy.name
p name

puts "____"
name = "fred"
fluffy = Pet.new(name)
name.capitalize!
p fluffy.name
# puts fluffy
p fluffy.name
p name
