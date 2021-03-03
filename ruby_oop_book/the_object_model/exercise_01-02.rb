# How do we create an object in Ruby? Give an example of the creation of an object.

# SG: We can create objects via instantiation or via typing (initializing?) a literal. Instantiation is the process creating a new object or instance from a class. The class could be a class from ruby's standard library or a custom class defined by a user.

module Communicate
  def talk_from_console(word)
    puts "#{word}"
  end
end

class CustomClass
  include Communicate
end

hash_std_1 = Hash.new
hash_std_2 = {}
custom_obj = CustomClass.new

# What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly.

# SG: A module is a collection of behaviors that we can leverage in one or more classes (via mixins). This allows us to define a module once and then reuse (or "include") in mutltiple classes.

custom_obj.talk_from_console("I am a custom object leveraging the Communicate module")
