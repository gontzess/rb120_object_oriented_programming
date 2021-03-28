#### OOP Book & Lessons

**What is OOP? List all the benefits of OOP?**
OOP stands for Object Oriented Programming. This paradigm of programming arose as software systems became more complex. OOP allows us to section off/contain code with similar functionality into smaller parts. This allows for easier maintenance, re usability, and readability. It also allows for easier program concepting using nouns (objects) and verbs (methods).
- reduce dependencies
- allow thinking on a new levels of abstraction
- better data protection only exposing intended functionality
- flexibility to reuse pre-written code
- ability to organize behaviors and attributes through more superclasses and specialized subclasses

**What is encapsulation? How is this achieved in Ruby?**
Encapsulation is hiding pieces of functionality from the larger program or code ecosystem. We can define specific, intentional ways to leverage the hidden functionality through a public interface. This serves as a form of data protection to avoid any unintentional data manipulation or changes.
Ruby achieves this through creating objects and exposing specific interfaces (methods) to interact with those objects.

**What is polymorphism? What are the different ways to apply polymorphism in Ruby?**
Polymorphism is the ability for different data types (ie objects) to leverage a common interface. Inheritance, mixins, and duck typing are all variations of polymorphism in Ruby.

**What is duck typing?**
Duck typing is a form of polymorphism where different kinds of objects can respond to the same method invocation. With duck typing, Ruby is not concerned with the class of the object, only that the object involved has the method available to it.

**What is class inheritance? How does this work in Ruby?**
Class inheritance is when a class inherits attributes and behaviors from another class (superclass). This gives us the ability to abstract more generalized, reusable attributes and behaviors to superclasses, and then keep more specialized characteristics to subclasses.

**What is an object?**
An instance of a class.

**What is a Class?**
A Class is a blueprint of attributes and behaviors for a specific object type. When we instantiate a new object or instance from a class, we use the details from the class definition.

**What is a Module?**
A module is a collection of like minded behaviors that do not fit clearly in a class hierarchy, but that we can mix in to specific classes that require the functionality. This is Ruby's way of implementing multiple inheritance, since class inheritance in ruby is limited to one superclass (each class can only inherit from / have one superclass).

**What are the differences between classes and modules? How do you decide which to use?**
Classes can only inherit from one class, the class immediate higher. Modules can be mixed in to as many classes as you'd like. You instantiate an object from a class, however you cannot create an object from a module. Therefore modules are used for namespacing or for grouping similar behaviors that do not fit cleanly in a class hierarchy.

**What is instantiation? Provide an example.**
Instantiation is the process of initializing a new instance of an object according to its class definition.

**What is the method lookup path? How is it important?**
The method lookup path is the sequence in which Ruby searches for a method definition when the method is called on an object. Ruby first starts with the class of the calling object (and any included modules in the class). If it does not find a definition, it will continue searching through each of the class's ancestors (each superclass and any mixed in modules) in a linear, ordered manner.

**How do we create an object in Ruby? Give an example of the creation of an object.**
We create an object by calling `.new` method to create an instance of the class. This instance of the class is an object.



__
**What is an instance variable? Provide an example.**
An instance variable is a variable that is scoped to a specific instance of the class. An instance variable is used to tie data to an object. It will live on as long as the object instance exits. They are designated by a single `@` in front of the name.

**What is an instance method? Provide an example.**
Instance methods are defined within a class definition, and pertain to a specific instance of that class. They have access all of the instance variables.
```ruby
class SomeClass
  ## extra code
  def display_name
    puts "The object's name is #{@name}."
  end
end

thing = SomeClass.new('Some Name')
thing.display_name  #=> outputs "The object's name is Some Name."
```


__
**Ex 2**
This code is an example of how modules can be mixed into classes to add additional functionality. in the example, we mix in `Speak` to the two classes `GoodDog` and `HumanBeing` using the method `include`. The two classes now have access to the `speak` method, so that on `line _` we can call `speak` on `sparky`, which in turn references a `GoodDog` object, and on `line _` we can call `speak` on `bob`, which in turn references a `HumanBeing` object. `speak` takes 1 argument, which is passed to `puts` as an argument and outputted to the console as a string. Therefore the code results in `Arf` and `Hello` being outputted to the screen.

**Ex 3**
This code is an example of modules can be mixed into classes tp provide additional functionality. In the example, we mix in `Speak`
