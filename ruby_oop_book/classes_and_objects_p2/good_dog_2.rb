class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :height, :weight #, :age

  @@number_of_dogs = 0

  def initialize(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
    #self.age = a * DOG_YEARS
    @@number_of_dogs += 1
  end

  def self.total_number_of_dogs  # class method definition
    @@number_of_dogs
  end

  def change_info(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end

  def what_is_self
    self
  end

  puts self
  # def to_s
  #   "This dog's name is #{name} and it is #{age} in dog years."
  # end
end

# puts GoodDog.total_number_of_dogs
#
# dog1 = GoodDog.new
# dog2 = GoodDog.new
#
# puts GoodDog.total_number_of_dogs


sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
p sparky.what_is_self
