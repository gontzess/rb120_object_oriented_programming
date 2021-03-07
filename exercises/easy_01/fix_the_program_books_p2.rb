# Complete this program so that it produces the expected output:
# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

class Book
  attr_accessor :title, :author

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# SG: Selecting the "better" implementation all depends on what we expect the user needs for the object will be.

#If we expect users will never need to set new values for `@title` and `@author` after initialization, then the first implementation is the better choice, since it doesn't allow for re-setting these instance variables. But it also means users must provide both values at the time of initialization.

# If we expect users will need to re-set these instance variables after initialization or if we expect users may not need all these instance variables at time of initialization, then the second implementation will prove a better choice.
