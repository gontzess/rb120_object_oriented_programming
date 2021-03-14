# We have the following. What can we add to the Bingo class to allow it to inherit the play method from the Game class?

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

# SG: added `< Game` onm `line 9` where we define the `Bingo` class. Now `Bingo` inherits from `Game`.

game_of_bingo = Bingo.new
p game_of_bingo.play #=> "Start the game!"
