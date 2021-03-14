# We have an Oracle class and a RoadTrip class that inherits from the Oracle class.

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

# What is the result of the following:

trip = RoadTrip.new
trip.predict_the_future

# SG: Same as the previous problem, except instead invoking `Oracle#choices` and then returning a random selection from the array on `line 9`, it will invoke `RoadTrip#choices` and return a random selection from the array on `line 15`. `RoadTrip#choices` overrides `Oracle#choices`, meaning Ruby will first check for `choices` in `RoadTrip` (the class of the object we're calling the method on). It will find the method in `RoadTrip`, and then stop searching.
