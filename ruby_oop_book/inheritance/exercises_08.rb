# Given the following code...
bob = Person.new
bob.hi
# And the corresponding error message...
=begin
NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
from (irb):8
from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'
=end
# What is the problem and how would you go about fixing it?

# SG: `hi` is defined as a private method for the class `person`. This means that the method is only available from within the class definition. To resolve, we would need to move the `hi` definition to be above the `private` keyword within the class definition.
