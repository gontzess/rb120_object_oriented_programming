# Add a class method to your MyCar class that calculates the gas mileage of any car.

class MyCar
  attr_accessor :color, :model, :speed
  attr_reader :year

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def speed_up(mph_increase)
    self.speed = [self.speed + mph_increase, 103].min
    puts "You push the gas and accelerate #{mph_increase} mph."
  end

  def brake(mph_decrease)
    self.speed = [self.speed - mph_decrease, 0].max
    puts "You push the brake and decelerate #{mph_decrease} mph."
  end

  def current_speed
    puts "You are now going #{self.speed} mph."
  end

  def shut_down
    self.speed = 0
    puts "Let's park this bad boy!"
  end

  def spray_paint(c)
    self.color = c
    puts "Your new #{self.color} paint job looks great!"
  end

  def info
    puts "The #{self.year} #{self.color} #{self.model} is traveling at #{self.speed} mph."
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def to_s
    "My car is a #{self.year} #{self.color} #{self.model}, and it is traveling at #{self.speed} mph."
  end
end

steves_car = MyCar.new(2004, 'brown', 'Chevy Malibu')
MyCar.gas_mileage(13, 351)

puts steves_car
