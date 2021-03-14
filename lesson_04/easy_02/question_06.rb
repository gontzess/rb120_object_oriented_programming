# I have the following class. Which one of these is a class method (if any) and how do you know? How would you call a class method?

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# `self.manufacturer` is a class method. it is defined with `def self.`

Television.manufacturer
