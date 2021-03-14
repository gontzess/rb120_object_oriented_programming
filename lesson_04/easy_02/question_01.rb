# You are given the following code:

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

# What is the result of executing the following code:

oracle = Oracle.new
oracle.predict_the_future

# SG: `line 15` instantiates a new `Oracle` object and assigns it to the local variable `oracle`. Then `line 16` calls `predict_the_future` on `oracle`, which returns a string. The string will be the concatenation of "You will " and one of 3 string elements in the array object defined and returned in the body of `Oracle#choices` on `line 9`.
