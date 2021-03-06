require 'time'

module Towable
  def can_tow?(lbs_weight)
    lbs_weight < 1000
  end
end

class Vehicle
  attr_accessor :year, :model, :color, :speed
  attr_reader :age

  @@number_of_vehicles = 0

  def initialize(y, m, c)
    self.year = y
    self.model = m
    self.color = c
    self.speed = 0
    @age = years_old
    @@number_of_vehicles += 1
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

  def self.number_of_vehicles
    puts "#{@@number_of_vehicles} objects created."
  end

  private

  def years_old
    Time.now.year - self.year
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4

  def to_s
    "My car is a #{self.color} #{self.year} #{self.model}, and it is traveling at #{self.speed} mph. It's also #{self.age} years old."
  end
end

class MyTruck < Vehicle
  include Towable

  NUMBER_OF_DOORS = 2

  def to_s
    "My truck is a #{self.color} #{self.year} #{self.model}, and it is traveling at #{self.speed} mph. It's also #{self.age} years old."
  end
end

steves_car = MyCar.new(2004, 'Chevy Malibu', 'brown')
delivery_truck = MyTruck.new(2018, 'Mac Big Boy', 'white')

puts steves_car
steves_car.speed_up(100)
puts steves_car

puts delivery_truck
delivery_truck.speed_up(50)
puts delivery_truck

Vehicle.number_of_vehicles
puts delivery_truck.can_tow?(1500)
# puts '--'
# puts MyCar.ancestors
# puts '--'
# puts MyTruck.ancestors
# puts '--'
# puts Vehicle.ancestors
