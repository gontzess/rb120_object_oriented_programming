# Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.

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
end

steves_car = MyCar.new(2004, 'brown', 'Chevy Malibu')
steves_car.speed_up(20)
steves_car.current_speed
steves_car.speed_up(200)
steves_car.current_speed
steves_car.brake(20)
steves_car.current_speed
steves_car.brake(20)
steves_car.current_speed
steves_car.shut_down
steves_car.current_speed

steves_car.color = 'orange'
puts steves_car.color
puts steves_car.year
steves_car.spray_paint('blue')
