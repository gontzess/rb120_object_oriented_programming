module Mod
  CONST = "This isn't the constant you're looking for..."
end

CONST = 'does it look globally?'

class MyClass
  include Mod
end

class MyOtherClass < MyClass
  def call_constant
    p Module.nesting
    p self.class.ancestors
    puts CONST
  end

  CONST = 'test location'
end

my_obj = MyOtherClass.new

my_obj.call_constant        # => I expect the return value to be: 'does it look globally?' but its "This isn't the constant you're looking for..."
