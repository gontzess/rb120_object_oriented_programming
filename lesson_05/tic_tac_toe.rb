# OO Tic Tac Toe program
module Formattable
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
end

class Board
  attr_reader :board_size, :center_key

  def initialize(board_size)
    @board_size = board_size
    @num_of_squares = board_size**2
    @center_key = (board_size**2 + 1) / 2
    @squares = {}
    reset_squares
    reset_winning_lines
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def display
    all_rows = winning_rows
    all_rows.each_with_index do |row, row_idx|
      pieces = []
      row.each_with_index do |key, square_idx|
        str = "  " + @squares[key].to_s
        str += "  " unless square_idx == board_size - 1
        pieces << str
      end
      puts "     |" * (board_size - 1)
      puts pieces.join('|')
      puts "     |" * (board_size - 1)
      puts ("-----+" * board_size).chop unless row_idx == board_size - 1
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def reset_squares
    (1..@num_of_squares).each { |key| @squares[key] = Square.new }
  end

  def reset_winning_lines
    rows = winning_rows
    columns = winning_columns
    diagonals = winning_diagonals(rows, columns)
    @winning_lines = rows + columns + diagonals
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def copy
    brd_clone = Board.new(board_size)
    (1..@num_of_squares).each do |key|
      brd_clone[key] = @squares[key].marker
    end
    brd_clone.update_winnable_lines
  end

  def unmarked_keys
    @squares.keys.select { |num| @squares[num].unmarked? }
  end

  def center_square
    @squares[@center_key]
  end

  def oversized?
    @board_size > 3
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/CyclomaticComplexity
  def at_risk_squares(player_marker, depth=1)
    at_risk = []
    depth = 1 if !oversized? ## if 3x3 board, ensure depth always 1
    @winning_lines.each do |line|
      squares, markers = content_from(line)
      if markers.count(player_marker) == board_size - depth &&
         squares.select(&:unmarked?).size == depth
        line.each do |key|
          at_risk << key if @squares[key].unmarked?
        end
      end
    end

    return nil if at_risk.empty?

    at_risk.sort_by { |key| at_risk.count(key) }.reverse.uniq
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/CyclomaticComplexity

  def terminal_node(marker, opponent_marker)
    certain_win = winning_marker == marker
    certain_loss = !!at_risk_squares(opponent_marker)
    certain_tie = draw_round?

    terminal_node = certain_tie || certain_win || certain_loss
    node_value = if certain_win      then 100
                 elsif certain_loss  then -100
                 elsif certain_tie   then 0
                 else                     unmarked_keys.length
                 end
    return terminal_node, node_value
  end

  def winning_marker
    @winning_lines.each do |line|
      squares, markers = content_from(line)
      if markers.uniq.size == 1 && squares.all?(&:marked?)
        return markers.first
      end
    end
    nil
  end

  def someone_won_round?
    !!winning_marker
  end

  def draw_round?
    update_winnable_lines
    @winning_lines.empty?
  end

  protected

  def update_winnable_lines
    @winning_lines.reject! { |line| unwinnable?(line) }
    self
  end

  private

  def winning_rows
    winning_rows = []
    (1..@num_of_squares).step(board_size) do |x|
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
      (x..@num_of_squares).step(board_size) do |y|
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

  def content_from(line)
    squares = @squares.values_at(*line)
    markers = squares.map(&:marker)
    return squares, markers
  end

  def unwinnable?(line)
    squares, markers = content_from(line)
    markers.uniq.size == 3 || squares.all?(&:marked?)
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    @marker == INITIAL_MARKER
  end

  def marked?
    @marker != INITIAL_MARKER
  end
end

class TTTPlayer
  attr_reader :marker, :wins

  def initialize(board, marker)
    @board = board
    @marker = marker
    @wins = 0
  end

  def won_round
    @wins += 1
  end

  def won_game?(max = TTTGame::ROUNDS_TO_WIN)
    @wins >= max
  end

  private

  attr_reader :board
end

class Human < TTTPlayer
  include Formattable

  def choose_move
    choice = nil
    loop do
      puts "Choose a square: " + joinor(board.unmarked_keys)
      choice = gets.chomp.to_i
      break if board.unmarked_keys.include?(choice)
      puts "That's not a valid choice."
    end
    choice
  end
end

class Computer < TTTPlayer
  def initialize(board, marker, opponent_marker, difficulty)
    super(board, marker)
    @opponent_marker = opponent_marker
    @difficulty = difficulty
    set_plies
  end

  def calculate_move
    case @difficulty
    when :competitive then find_competitive_move
    when :minimax     then find_minimax_move
    when :negamax     then find_negamax_move
    end
  end

  private

  INFINITY = Float::INFINITY

  def set_plies
    @plies = case board.board_size ## set recommended max plies
             when 3 then 10
             when 5 then 10
             else        3
             end
  end

  def find_wins_threats(depth=1)
    wins = board.at_risk_squares(@marker, depth)
    threats = board.at_risk_squares(@opponent_marker, depth)
    return wins, threats
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def find_competitive_move
    immediate_wins, immediate_threats = find_wins_threats

    if board.oversized?
      look_ahead_wins, look_ahead_threats = find_wins_threats(2)
    end

    if !!immediate_wins
      immediate_wins.first
    elsif !!immediate_threats
      immediate_threats.first
    elsif board.center_square.unmarked?
      board.center_key
    elsif board.oversized? && !!look_ahead_wins
      look_ahead_wins.first
    elsif board.oversized? && !!look_ahead_threats
      look_ahead_threats.first
    else
      board.unmarked_keys.sample
    end
  end
  # rubocop:enable Metrics/PerceivedComplexity

  def minimax(square_key, brd, depth, side=1)
    brd_copy = brd.copy
    marker = side.positive? ? @marker : @opponent_marker
    brd_copy[square_key] = marker

    terminal_node, value = brd_copy.terminal_node(@marker, @opponent_marker)
    return depth * value if terminal_node || depth == 0

    case side
    when 1 ## Computer aka maximizing player
      value = -INFINITY
      brd_copy.unmarked_keys.each do |key|
        value = [value, minimax(key, brd_copy, (depth - 1), -side)].max
      end
      value
    when -1 ## Player aka minimizing player
      value = INFINITY
      brd_copy.unmarked_keys.each do |key|
        value = [value, minimax(key, brd_copy, (depth - 1), -side)].min
      end
      value
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/CyclomaticComplexity

  def find_minimax_move(brd=@board, depth=@plies, side=1)
    empty_keys = brd.unmarked_keys
    return brd.center_key if brd.center_square.unmarked?
    return find_competitive_move if empty_keys.length > 9

    weights = empty_keys.each_with_object({}) do |key, hash|
      hash[key] = minimax(key, brd, depth, side)
    end
    max_weight = weights.values.max
    max_keys = weights.select { |_, val| val == max_weight }.keys

    return max_keys.first if max_keys.length == 1

    max_keys.sample
  end

  def negamax(square_key, brd, depth, side=1)
    brd_copy = brd.copy
    marker = side.positive? ? @marker : @opponent_marker
    brd_copy[square_key] = marker

    terminal_node, value = brd_copy.terminal_node(@marker, @opponent_marker)
    return side * depth * value if terminal_node || depth == 0

    value = -INFINITY

    brd_copy.unmarked_keys.each do |key|
      value = [value, -negamax(key, brd_copy, (depth - 1), -side)].max
    end
    value
  end

  def find_negamax_move(brd=@board, depth=@plies, side=1)
    empty_keys = brd.unmarked_keys
    return brd.center_key if brd.center_square.unmarked?
    return find_competitive_move if empty_keys.length > 9

    weights = empty_keys.each_with_object({}) do |key, hash|
      hash[key] = negamax(key, brd, depth, side)
    end
    max_weight = weights.values.max
    max_keys = weights.select { |_, val| val == max_weight }.keys

    return max_keys.first if max_keys.length == 1

    max_keys.sample
  end
end

class TTTGame
  include Formattable

  HUMAN_MARKER = "X" ## set after the fact w/ human.marker?
  COMPUTER_MARKER = "O"
  ROUNDS_TO_WIN = 3
  BOARD_SIZE = 3 ## ie choose 3, 5
  DIFFICULTY = :negamax ## choose :competitive, :minimax, :negamax

  def initialize
    @board = Board.new(BOARD_SIZE)
    set_human_marker
    set_computer_marker
    @human = Human.new(@board, HUMAN_MARKER)
    @computer = Computer.new(@board, COMPUTER_MARKER, HUMAN_MARKER, DIFFICULTY)
    @round = 1
    set_first_move
  end

  def play
    display_welcome_message
    loop do
      players_move
      display_round_results
      break if someone_won_game? || !continue_to_next_round?
      reset
    end
    display_game_results if someone_won_game?
    display_goodbye_message
  end

  private

  attr_accessor :board
  attr_reader :human, :computer

  def display_welcome_message
    clear_screen
    puts "Welcome to Tic Tac Toe!"
  end

  def display_rules_message
    puts "Welcome #{human.name}!"
    puts "You will be playing against #{computer.name}."
    puts "The first to #{ROUNDS_TO_WIN} rounds wins all!"
    puts "Press enter to begin."
    gets.chomp
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    # clear_screen
    puts "You (Player) are #{human.marker}s. Computer is #{computer.marker}s."
    puts ""
    board.display
    puts ""
  end

  def set_first_move
    @current_marker = @round.odd? ? HUMAN_MARKER : COMPUTER_MARKER
  end

  def human_moves
    choice = human.choose_move
    board[choice] = human.marker
  end

  def computer_moves
    choice = computer.calculate_move
    board[choice] = computer.marker
  end

  def current_player_moves
    case @current_marker
    when human.marker
      display_board
      human_moves
      @current_marker = COMPUTER_MARKER
    when computer.marker
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def players_move
    loop do
      current_player_moves
      break if board.someone_won_round? || board.draw_round?
    end
  end

  def display_score
    puts "You: #{human.wins}, Computer: #{computer.wins}."
  end

  # rubocop:disable Metrics/MethodLength
  def display_round_results
    display_board
    case board.winning_marker
    when human.marker
      human.won_round
      puts "You won this round!"
    when computer.marker
      computer.won_round
      puts "Computer won this round!"
    else
      puts "It's a draw!"
    end
    display_score
  end
  # rubocop:enable Metrics/MethodLength

  def reset
    @round += 1
    set_first_move
    board.reset_squares
    board.reset_winning_lines
  end

  def continue_to_next_round?
    answer = nil
    loop do
      puts "Continue to the next round? (y or n)"
      answer = gets.chomp.downcase
      break if %w(y n yes no).include?(answer)
      puts "That's not a valid choice."
    end
    answer == 'y' || answer == 'yes'
  end

  def someone_won_game?
    human.won_game? || computer.won_game?
  end

  def display_game_results
    case human.wins <=> computer.wins
    when 1  then puts "You won the game!"
    when -1 then puts "Computer won the game!"
    else         puts "Error, we tiredddd, we give up!"
    end
  end
end

game = TTTGame.new
game.play
