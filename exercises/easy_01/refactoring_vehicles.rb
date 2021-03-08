# Refactor these classes so they all use a common superclass, and inherit behavior as needed.

class Vehicle
  WHEELS = 4

  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end

  def wheels
    self.class::WHEELS
  end
end

class Car < Vehicle
  WHEELS = 4
end

class Motorcycle < Vehicle
  WHEELS = 2
end

class Truck < Vehicle
  WHEELS = 6

  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end
end

# FURTHER EXPLORATION: Would it make sense to define a wheels method in Vehicle even though all of the remaining classes would be overriding it? Why or why not? If you think it does make sense, what method body would you write?

# SG: No, it would only make sense if you had a clear, obvious default for vehicle wheels. Like if we knew that most vehicles have 4 wheels and we were comfortable with that assumption, we could write the above code ^. Not sure we can make this decision with confidence at the moment with the information provided.


steves_car = Car.new('chevy', 'malibu')
puts steves_car
puts steves_car.wheels

steves_moto = Motorcycle.new('harley', 'low rider')
puts steves_moto
puts steves_moto.wheels

steves_truck = Truck.new('ford', 'f-350', 1500)
puts steves_truck
puts steves_truck.wheels

steves_vehicle = Vehicle.new('circus', 'clown car')
puts steves_vehicle
puts steves_vehicle.wheels
