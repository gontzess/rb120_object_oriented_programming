# Which of these two classes has an instance variable and how do you know?

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# SG: `Class::Pizza` has an instance variable `@name`. We know this b/c it's prefaced with `@`.

p Pizza.new("cheese").instance_variables #=> [:@name]
p Fruit.new("apple").instance_variables #=> []
