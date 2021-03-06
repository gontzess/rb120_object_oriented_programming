class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    # last_name.empty? ? "#{first_name}" : "#{first_name} #{last_name}"
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  def same_name?(other_person)
    self.name == other_person.name
  end

  def to_s
    name
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    if parts.size > 1
      self.first_name, self.last_name = parts
    else
      self.first_name, self.last_name = parts.first, ''
    end
  end
end

# problem 1:
# bob = Person.new('bob')
# p bob.name                  # => 'bob'
# bob.name = 'Robert'
# p bob.name                  # => 'Robert'

# problem 2:
# bob = Person.new('Robert')
# p bob.name                  # => 'Robert'
# p bob.first_name            # => 'Robert'
# p bob.last_name             # => ''
# bob.last_name = 'Smith'
# p bob.name                  # => 'Robert Smith'
# joe = Person.new('Joe', 'Blow')
# p joe.name
# p joe.first_name
# p joe.last_name

# problem 3:
# bob = Person.new('Robert')
# p bob.name                  # => 'Robert'
# p bob.first_name            # => 'Robert'
# p bob.last_name             # => ''
# bob.last_name = 'Smith'
# p bob.name                  # => 'Robert Smith'
# bob.name = "John Adams"
# p bob.first_name            # => 'John'
# p bob.last_name             # => 'Adams'
# p bob.name

# problem 4:
# bob = Person.new('Robert Smith')
# rob = Person.new('Robert Smith')
# jim = Person.new('Jim Bob')
# p bob.same_name?(rob)
# p bob.same_name?(jim)
# p bob.name == rob.name
# p bob.name == jim.name

# problem 5:
bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
