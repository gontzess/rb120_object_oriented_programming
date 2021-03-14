# If we have this code:

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# What happens in each of the following cases:

# case 1:
hello = Hello.new
hello.hi
# SG: We initialize a local variable `hello` and assign it to the return value of `Hello.new`, which is a new `Hello` object that we instantiate. Then we call `Hello#hi` on the `Hello` object that `hello` references. The method call returns the value of `greet("Hello")` which the `Hello` class has access to through inheritance from the `Greeting` class. This outputs "Hello" to the screen.

# case 2:
hello = Hello.new
hello.bye
# SG: This returns an error for undefined method `bye` of class `Hello`. This is because the `Hello` class (and it's ancestors) do not have a `bye` method defined.

# case 3:
hello = Hello.new
hello.greet
# SG: This returns a method argument error. `Hello` class inherits the `Greeting#greeting` method, however this method expects 1 argument and we try to invoke it with 0 arguments.

# case 4:
hello = Hello.new
hello.greet("Goodbye")
# SG: This outputs "Goodbye" to the screen, since now we provide 1 argument when we invoke the method.

# case 5:
Hello.hi
# SG: This returns an error for undefined method `Hello::hi`. Class `Hello` (and it's ancestors) does not have a class method `self.hi` defined.
