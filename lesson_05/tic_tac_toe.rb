# OO Tic Tac Toe program

class Board
  INITIAL_MARKER = ' '

  attr_reader :board_size, :num_of_squares, :winning_lines

  def initialize(board_size)
    @board_size = board_size
    @num_of_squares = board_size**2
    set_squares
    set_winning_lines
  end

  def display
    all_rows = winning_rows
    all_rows.each_with_index do |row, row_idx|
      pieces = []
      row.each_with_index do |square_num, square_idx|
        str = "  " + get_square_at(square_num).to_s
        str += "  " unless square_idx == board_size - 1
        pieces << str
      end
      puts "     |" * (board_size - 1)
      puts pieces.join('|')
      puts "     |" * (board_size - 1)
      puts ("-----+" * board_size).chop unless row_idx == board_size - 1
    end
  end

  def get_square_at(key)
    @squares[key]
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
  end

  def empty_squares
    @squares.keys.select { |num| @squares[num].marker == INITIAL_MARKER }
  end

  private

  def winning_rows
    winning_rows = []
    (1..num_of_squares).step(board_size) do |x|
      row = []
      (0..board_size - 1).each do |y|
        row << x + y
      end
      winning_rows << row
    end
    winning_rows
  end

  def winning_columns
    winning_columns = []
    (1..board_size).each do |x|
      column = []
      (x..num_of_squares).step(board_size) do |y|
        column << y
      end
      winning_columns << column
    end
    winning_columns
  end

  def winning_diagonals(winning_rows, winning_columns)
    diagonal1 = []
    diagonal2 = []
    (0..board_size - 1).each do |idx|
      other_idx = (board_size - 1) - idx
      diagonal1 << winning_rows[idx][idx]
      diagonal2 << winning_columns[other_idx][idx]
    end
    [diagonal1, diagonal2]
  end

  def set_winning_lines
    rows = winning_rows
    columns = winning_columns
    diagonals = winning_diagonals(rows, columns)
    @winning_lines = rows + columns + diagonals
  end

  def set_squares
    @squares = (1..num_of_squares).each_with_object({}) do |num, new_board|
                 new_board[num] = Square.new(INITIAL_MARKER)
               end
  end
end

class Square
  attr_accessor :marker

  def initialize(marker)
    @marker = marker
  end

  def to_s
    @marker
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end

  def mark
    #
  end
end

class TTTGame
  def initialize
    @board = Board.new(3)
    @human = Player.new('X')
    @computer = Player.new('O')
  end

  def play
    display_welcome_message
    loop do
      display_board
      human_moves
      # display_board
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end

  private

  attr_accessor :board
  attr_reader :human, :computer

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen
    (system 'clear') || (system 'cls')
  end

  def joinor(ary, divider=', ', ending='or')
    case ary.length
    when 0 then ''
    when 1 then ary.first.to_s
    when 2 then ary.join(" #{ending} ")
    else
      ary[0..-2].join(divider) + "#{divider}#{ending} #{ary.last}"
    end
  end

  def display_board
    clear_screen
    puts "You (Player) are #{human.marker}s. Computer is #{computer.marker}s."
    puts ""
    board.display
    puts ""
  end

  def human_moves
    choice = nil
    loop do
      puts "Choose a square: " + joinor(board.empty_squares)
      choice = gets.chomp.to_i
      break if board.empty_squares.include?(choice)
      puts "Invalid input, try again."
    end
    board.set_square_at(choice, human.marker)
  end

end

game = TTTGame.new
game.play
