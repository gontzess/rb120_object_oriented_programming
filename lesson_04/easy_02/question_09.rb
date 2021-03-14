# We have this class. What would happen if we added a play method to the Bingo class, keeping in mind that there is already a method of this name in the Game class that the Bingo class inherits from.

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# SG: Adding a `Bingo#play` method would override `Game#play`, meaning that anytime you call `play` on an instance of a `Bingo` object Ruby will invoke `Bingo#play` not `Game#play`. Invoking `play` on a `Game` object would still invoke `Game#play`.
