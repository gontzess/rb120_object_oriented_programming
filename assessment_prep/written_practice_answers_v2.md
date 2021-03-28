#### Concepts & Definitions

**Object Oriented Programming**
- programming paradigm created to deal with growing complexity of programs and software systems
- allows programmers to section off/organize code to make programs the interaction of many small parts, instead of one big ball of dependencies
- the three pillars of OOP in Ruby (encapsulation, polymorphism, and abstraction) enable programmers the OOP foundation to create more scalable, efficient, and manageable programming

**Building Blocks of OOP in Ruby**
1. Encapsulation
  - Method Access Control
2. Polymorphism
  - Class Inheritance
    - Method Lookup Path
    - Method Overriding
  - Interface Inheritance
  - Duck Typing
3. Abstraction
  - encapsulate & extract complex states and behaviors into objects

A **class** is a "blueprint" for creating a specific data type (aka an object). In other words, a class defines the states/attributes and behaviors for it's objects. In Ruby, all classes inherit (or subclass) from `Object`, meaning all classes are decedents of the `Object` class.

An **object** is an instance of a class. When we instantiate an object, it is created based on attributes and behaviors defined in the class. Each object has a unique state and so any two objects instantiated from the same class will have different states. To create a new object, we must define a class, then call the `.new` method on that class to **instantiate** a new instance (aka a new object).
  ```ruby
  class Doggie
  end

  spot = Doggie.new
  ```

A **module** is a grouping of like-minded, re-usable behaviors that does not fit cleanly in a class hierarchy system. Defining these behaviors in a module allows us to keep the functionality in one central place. We then mix in a module to classes (using the `Module#include` method) so that the classes inherit the interfaces defined in the module. In Ruby we can mix in as many modules to a class as we'd like (aka interface inheritance), unlike class inheritance where a class can only sub-class from one parent class. Modules are also used as a namespace.
  ```ruby
  module Speakable
    def speak(sound)
      puts sound
    end
  end

  class Doggie
    include Speakable   # mixin Speakable module
  end

  class Person
    include Speakable   # mixin Speakable module
  end

  spot = Doggie.new
  spot.speak("Woof!")   # => Woof!
  jimbob = Person.new
  jimbob.speak("Hello!")   # => Hello!
  ```

**Encapsulation**
- Encapsulation is hiding/protecting pieces of functionality from the larger world (ie code base). It serves as a form of data protection, allowing programmers to shield internal data (and functionality) from unwanted or accidental changes or manipulation. Ruby accomplishes this by creating objects and explicitly defining/exposing interfaces (ie methods) for the larger world to interact with those objects. Encapsulation is one of 3 major pillars of OOP in Ruby.

**Method Access Control**
- Method Access Control in Ruby allows us to further encapsulate functionality by setting instance methods with the access modifiers `public`, `private`, or `protected`. This provides three different levels/degrees of access to the outside world.

**Polymorphism**
- Polymorphism is the ability for multiple data types to interact with a common interface (ie method). This means that that we can invoke a single method on multiple types of objects, and Ruby will happily run the code so long as we have that method defined for each of those objects. Often times the method implementations will vary for different object types, but the important part is that you can use the interface (call the method) in the same way. In Ruby there are several ways this can be achieved: class inheritance, interface inheritance, and duck-typing. Polymorphism is one of 3 major pillars of OOP in Ruby.
[example](https://launchschool.com/posts/b2b56435)

**Class Inheritance**
- Class Inheritance is where a class inherits attributes and behaviors from another. In Ruby each class has exactly one superclass, or class from which it inherits directly from. Class inheritance allows us to organize and classify objects into a hierarchical structure, so that more general/reusable attributes and behaviors can be rolled up higher in the chain, and more specialized attributes and behaviors can be set further down for subclasses.
- We use the `<` symbol to signify that `GoodDog` class is inheriting from the `Animal` class defined prior.
  ```ruby
  class Doggie < Animal
  end
  ```

**Method Lookup Path**
- Ruby uses the "chain" of class inheritance when a method is invoked and it then must search for the method definition. This is known as the Method Lookup Path. Ruby first starts with the class of the calling object. If it doesn't find the definition, it then searches any modules included in the class (last included up to first). Then if still not found, Ruby moves up the inheritance line to the next superclass (and if needed, that class's modules), etc in a linear, upward fashion. In Ruby we can see the lookup path for a given class by calling `Class#ancestors` on the object's class.

**Method Overriding**
- Method Overriding refers to when a subclass redefines a method that it already inherits from an ancestor. In this case, the method name must be the same, but the implementation can be (and usually is) different. We know that when we call the overridden method on an instance of the subclass, Ruby will always search the subclass for the definition first, find that definition, and then use that implementation. This method overriding ability enables polymorphism via inheritance in Ruby, since we can call a single interface on  objects of the superclass and of the subclass noted above.

**Interface Inheritance**
- Interface Inheritance is where a class inherits behaviors (or interfaces) from a module. This is done by mixing in a module to a class with the method `Module#include`. While classes can only directly subclass from one superclass in Ruby (aka single inheritance), they can inherit interfaces from as many modules as we'd like. This is how Ruby solves for multiple inheritance cases/needs. Interface inheritance allows for another form of polymorphism in Ruby, in that we can call a mixed in method from multiple classes.

**Duck Typing**
- Ruby employs a third form of polymorphism, Duck Typing. With Duck Typing, unlike Inheritance, Ruby is not concerned with the class of an object. If an object has a method defined for it, then we can call that specific method on the object, and that's all Ruby needs to know to carry out the method invocation. In other words, if an animal quacks like a duck, we don't care what type of animal it is, only that we can make it quack. Duck typing can be easily achieved by explicitly defining the same instance method name within multiple classes.

**Abstraction**
- Abstraction is when a complex state and set of behaviors are simplified into a single entity (ie a class object). Leveraging encapsulation, we can abstract away all the complex, specific nuances within a program, to instead focus on the major nouns (objects) and verbs (methods) in a program. This allows programmers to better conceptualize programs and write more intuitive code. Abstraction is one of 3 major pillars of OOP in Ruby.

**Instance Variables**
- Instance Variables keep track of information about the state of an object. Instance variables are scoped at the object level (aka instance level) and exist as long as the object instance exists. Every object's state is unique, and instance variables are how we keep track. They are written with the `@`symbol in front (ie `@name`).
  ```ruby
  class Doggie
    def initialize(name)
      @name = name
    end
  end

  spot = Doggie.new("Spot")
  ```

**Instance Methods**
- Instance Methods expose behaviors for objects (or instances) of that class. Instance methods are scoped at the object (aka instance level), meaning when we define an instance method within a class, we can only call the instance method on an instance of that class. Instance methods have access to all the variables of that instance (aka object).
  ```ruby
  class Doggie
    def initialize(name)
      @name = name
    end

    def speak
      "Woof!"
    end

    def greet
      "#{@name} says woof!"
    end
  end

  spot = Doggie.new("Spot")
  puts spot.speak   # => Woof!
  bruiser = Doggie.new("Bruiser")
  puts bruiser.speak   # => Woof!
  ```

**Class Variables**
- Class Variables are variables used to capture information for an entire class (ie at the class level). Class variables are created prepending `@@`.
  ```ruby
  class Doggies
    @@total_doggies = 0            # initialized at the class level

    def initialize
      @@total_doggies += 1         # mutable from instance method
    end

    def self.total_doggies
      @@total_doggies              # accessible from class method
    end
  end

  Doggie.total_doggies             # => 0
  Doggie.new
  Doggie.new
  Doggie.total_doggies             # => 2
  ```

**Class Methods**
- Class Methods are methods we can call directly on the class itself, without having to instantiate any objects (ie they are class level methods). Class methods are where we put functionality that doesn't pertain to the instance level. When defining a class method, we always prepend the method name with the reserved word `self.`
  ```ruby
  def self.what_am_i
    "I'm a #{self} class."
  end

  Doggie.what_am_i   # => I'm a Doggie class.
  ```

**Instance Variables vs Class Variables**
Once initialized, instance variables are only accessible and modify-able from within a specific instance of a class (via an instance method). Once initialized, a class variable is shared across all instances of a class and any of it's subclasses. So a class variable is accessible and modify-able to all instances of the class (and all/any instances of subclasses) via instance methods. A class variable is also accessible and modify-able via class methods, so without the involvement of an instance.

**Instance Methods vs Class Methods**
- Both method types are leveraged within class definitions however they vary in purpose, scope, and syntax. Instance methods are used to expose behaviors for objects (instances of a class), while class methods are used to expose behaviors class-wide.
- As a result instance methods are scoped at the instance level while class methods are scoped at the class level. This means that we call instance methods on instances of a class (ie an object) to perform operations on that object, while we call class methods directly on the class itself, without having to instantiate any objects, to perform operations at the class level.
- The syntax for defining and calling these two types of methods follows these differences.

**Getter & Setter Methods**
- A getter method's job is to return an instance variable for viewing
  ```ruby
  puts spot.name
  ```
- A setter method's job is to change the value of an instance variable
  ```ruby
  spot.name = "Spotty"
  spot.name=("Spotty") # longhand, same as the above
  ```
- Typically you should name getter and setter methods using the same name as the instance variable they are exposing and setting.

**`attr_*`**
- We can leverage the `attr_accessor` built in method to automatically create getter and setter methods for us
- use the `attr_reader` method if you only want the `getter` method without the `setter` method
- use the `attr_writer` method if you only want the `setter` method
- This one line of code below gives us six getter/setter instance methods: `name`, `name=`, `height`, `height=`, `weight`, `weight=`. It also gives us three instance variables: `@name`, `@height`, `@weight`.
  ```ruby
  attr_accessor :name, :height, :weight
  ```
- When using setter methods, need to use `self.name=` or `self.name =` (for example) instead of `name =` so ruby knows we're calling a method not creating a local variable. It's ok to leave out the `self.` for getter methods

**Private vs Protected vs Public Instance Methods**
- A **public method** is a method that is available to anyone who knows either the class name or the object's name.
- A **private method** is a method that is doing work in the class but we don't need it to be available to the rest of the program.
  - only accessible from other methods within the class definition
  - only accessible from inside the class when called without `self` (technically now allowed in Ruby 2.7 +)
- A **protected method** is in between:
  - from inside the class, `protected` methods are accessible just like `public` methods.
  - from outside the class, `protected` methods act just like `private` methods.
- When a method is protected, only instances of the class or a subclass can call the method. This means we can easily share sensitive data between instances of the same class type.

**Private vs Protected Methods**
- Protected methods allow access between between class instances, while private methods only allow access to a single instance of a class. This means that we can use protected methods to share sensitive information between instances of a class, without having to make them public.

**Class Inheritance vs Module Mixins**
- You can only subclass (class inheritance) from one class, aka from the class immediately higher. You can mix in as many modules (interface inheritance) as you'd like.
- If there's an "is-a" relationship, class inheritance is usually the correct choice. If there's a "has-a" relationship, interface inheritance is generally a better choice. For example, a dog "is an" animal and it "has an" ability to swim.
- You cannot instantiate modules (i.e., no object can be created from a module). Modules are used only for namespacing and grouping common methods together.

**self**
- There are two use cases for `self` from within a class:
  1. `self`, inside of an instance method, references the instance (object) that called the method - the calling object. Therefore, `self.weight=` is the same as `sparky.weight=`, in our example.
  2. `self`, outside of an instance method, references the class and can be used to define class methods. Therefore if we were to define a name class method, `def self.name=(n)` is the same as `def GoodDog.name=(n)`.

**Fake Operators**
![image](file:///home/gontzess/Pictures/ls_resources/ruby_fake_operators.png)

**Equivalence**
- The `==` method compares the two variables' values whereas the `equal?` method determines whether the two variables point to the same object.

**The `==` method**
- the `==` method compares the values of the objects (called the "equality operator")
- by default, `BasicObject#==` does not perform an equality check; instead, it returns true if two objects are the same object. This is why other classes often provide their own behavior for `#==`.

**The `equal?` method**
- the `equal?` method goes one level deeper than `==` and determines whether two variables not only have the same value, but also whether they point to the same object. It's like comparing two objects' `object_id`
- do not define `equal?` - don't mess with it.

**The `===` method**
- used implicitly in case statements, rarely need to call this method explicitly
- When `===` compares two objects, such as `(1..50) === 25`, it's essentially asking "if (1..50) is a group, would 25 belong in that group?"

**The `eql?` method**
- The `eql?` method determines if two objects contain the same value and if they're of the same class.
- used implicitly by `Hash`, very rarely used explicitly.

  ```ruby
  str1 = "something"
  str2 = "something"
  str1_copy = str1

  # comparing the string objects' values
  str1 == str2            # => true
  str1 == str1_copy       # => true
  str2 == str1_copy       # => true

  # comparing the actual objects
  str1.equal? str2        # => false
  str1.equal? str1_copy   # => true
  str2.equal? str1_copy   # => false

  # comparing the classes of the objects and the values of the objects
  str1.eql? str2        # => true
  str1.eql? str1_copy   # => true
  str2.eql? str1_copy   # => true
  ```

**Collaborator Objects**
Collaborator objects are objects that are stored as state within another object. Usually these are objects of a custom class that we then assign to instance variables within another custom class. Collaborator objects are important in OOP, since they help tie together (and often chain) the nouns in your program. This allow you to modularize complicated problems into smaller customized pieces, to closely model your problem/needs.
  ```ruby
  class Person
    attr_accessor :name, :pet

    def initialize(name)
      @name = name
    end
  end

  rickybobby = Person.new("Ricky Bobby")
  spot = Doggie.new             # assume Doggie class from earlier

  rickybobby.pet = spot
  rickybobby.pet.speak                 # => "Woof!"
  ```

#### Precise Language
- **Constants:**
  - When Ruby **resolves** a constant, it looks it up in its lexical scope first, followed by each of its ancestor classes (if needed).
  - Explicit namespacing `self.class::`
- **Super:**
  - The keyword `super` calls a method further up the inheritance chain that has the same name as the enclosing method.
  - (By enclosing method, we mean the method where we are calling the keyword `super`.)
- **Instantiation:**
  - We have instantiated an object called X from the class Y
  - We refer to the `initialize` method as a **constructor**, because it gets triggered whenever we create a new object.
- **Vocab reminder:**
  - Method - invocation
  - Variable - initialization (or reassignment)
  - Object - instantiation
- **Truthy**
  - use "evaluates to true" or "is truthy" when discussing an expression that evaluates to true in a boolean context.
  - an expression evaluates to `true` or `false`
  - everything in ruby is "truthy" except `false` and `nil`
- **True**
  - use "is true" or "is equal to true" only when specifically discussing the boolean `true`
  - remember that `true` and `false` are objects of `TrueClass` and `FalseClass` respectively
