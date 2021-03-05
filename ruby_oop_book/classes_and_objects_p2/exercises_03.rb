class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
p bob.name
bob.name = "Bob"
p bob.name

# When running the above code... we get an error undefined method `name=' . Why do we get this error and how do we fix it?

# SG: We get this error because `line 10` is trying to use a setter method for the `@name` instance variable, however only a getter method has been defined. We can fix this by changing `line 2` from `attr_reader` to `attr_accessor` so that both a getter and a setter method are defined for ``@name`.
