# Consider the following program. Update this code so that when you run it, you see the following output:
# My cat Pudding is 7 years old and has black and white fur.
# My cat Butterscotch is 10 years old and has tan and white fur.

# class Pet
#   def initialize(name, age)
#     @name = name
#     @age = age
#   end
# end

# class Cat < Pet
#   def initialize(name, age, colors)
#     super(name, age)
#     @colors = colors
#   end
#
#   def to_s
#     "My cat #{@name} is #{@age} years old and has #{@colors} fur."
#   end
# end


# Further Exploration: An alternative approach to this problem would be to modify the Pet class to accept a colors parameter. If we did this, we wouldn't need to supply an initialize method for Cat.
# Why would we be able to omit the initialize method? Would it be a good idea to modify Pet in this way? Why or why not? How might you deal with some of the problems, if any, that might arise from modifying Pet?

class Pet
  def initialize(name, age, colors='no')
    @name = name
    @age = age
    @colors = colors
  end
end

class Dog < Pet
  def to_s
    "My dog #{@name} is #{@age} years old."
  end
end

class Cat < Pet
  def to_s
    "My cat #{@name} is #{@age} years old and has #{@colors} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
bitters = Cat.new('Bitters', 9)
spot = Dog.new('Spot', 3)
puts pudding, butterscotch, bitters
puts spot

# SG: Probably not a great idea to modify `Pet` unless you have a clear view of all other subclasses of `Pet`. If `Cat` turns out to be the only subclasses of `Pet` now and for the foreseeable future, you could adjust `initialize` in `Pet` to accept 3 parameters, no problem. (But then why have `Cat` as a subclass in this scenario?)

# A more likely scenario is that another class (ie `Dog`) subclasses from `Pet` as well and has different needs - then you would likely run into some annoying edgecases. For example it would get tricky if `Dog` does not need a `@color` variable in it's class. In which case you have to monkey around with making `color` an optional/defaulted parameter in `initialize`. Then should a user try to initialize a `Cat` object without a 3rd arugment for `color`, you have to deal with strange default values for `@color` in your `Cat` instance methods, like `Cat##to_s`.
