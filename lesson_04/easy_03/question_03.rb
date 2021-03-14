# When objects are created they are a separate realization of a particular class.
#
# Given the class below, how do we create two different instances of this class with separate names and ages?

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

# SG: we initialize an instance of a class with `Class::new`. We can do it twice if we want two instances, ensuring we provide values for name and age, specifically with different values.

grumpy = AngryCat.new(19, 'grumpy')
stinky = AngryCat.new(16, 'stinky')

p grumpy.object_id
grumpy.age
grumpy.name

p stinky.object_id
stinky.age
stinky.name
