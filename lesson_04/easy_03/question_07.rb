# What is used in this class but doesn't add any value?

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end

end


# SG: Both of the instance variables `@brightness` and `@color` are used in that they are initialized, however they are never referenced. Similiarly the getter and setter methods for both of these instance variables do not add any value, but they are also never used..
# SG: Also the `return` on `line 12` is redundent since Ruby always returns the result of the last line of a method.
# SG: This whole class definition does not add any value, thank you.
