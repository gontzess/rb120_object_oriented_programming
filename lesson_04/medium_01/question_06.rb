# If we have these two methods:

class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

# and

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

# What is the difference in the way the code works?

# SG: The `show_template` methods function identically. Both `template` and `self.template` are invoking the getter method for `@template`.
# The `create_template` methods are defined differently, but achieve the same results, in this case specifically. The first one accesses the `@template` instance variable directly and reassigns it on `line 7`. The second one uses `self.template` setter method to re-assign the instance variable. In this case, we end up with the same result, however if the template setter method had been a custom defined setter with additional logic, then we would have different results.
