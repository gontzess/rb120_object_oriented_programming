# On lines 37 and 38 of our code, we can see that grace and ada are located at the same coordinates. So why does line 39 output false? Fix the code to produce the expected output.

class Person
  attr_reader :name
  attr_accessor :location

  def initialize(name)
    @name = name
  end

  def teleport_to(latitude, longitude)
    @location = GeoLocation.new(latitude, longitude)
  end
end

class GeoLocation
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def to_s
    "(#{latitude}, #{longitude})"
  end

  def ==(other_geo) ## added this.
    @latitude == other_geo.latitude && @longitude == other_geo.longitude
  end
end

# Example

ada = Person.new('Ada')
ada.location = GeoLocation.new(53.477, -2.236)

grace = Person.new('Grace')
grace.location = GeoLocation.new(-33.89, 151.277)

ada.teleport_to(-33.89, 151.277)

puts ada.location                   # (-33.89, 151.277)
puts grace.location                 # (-33.89, 151.277)
puts ada.location == grace.location # expected: true
                                    # actual: false
# SG: the instance variables `grace#location` and `ada#location` both point to a `GeoLocation` object with a value of -33.89/151.277 lat/long, however they are two separate `GeoLocation` objects. The `GeoLocation` class does not have a `==` method defined, so we can assume here that it inherits from `BasicObject`, which by default checks to see if the two objects are the same object. We can fix this by defining `GeoLocation#==`.
