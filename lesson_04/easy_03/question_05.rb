# If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# What would happen if I called the methods like shown below?

tv = Television.new
tv.manufacturer #=> undefined method error. `Television::manufacturer` is a class method not an instance method.
tv.model #=> invokes as defined in `line 9`

Television.manufacturer #=> invokes as defined in `line 5`
Television.model #=> undefined method error. `Television#model` is an instance method not a class method.
