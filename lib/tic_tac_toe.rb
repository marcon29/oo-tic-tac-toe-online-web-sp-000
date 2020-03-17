class TicTacToe
  def initialize
    @board = Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ]
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i-1
  end

  def move(index, current_player="X")
    @board[index] = current_player
  end

  def position_taken?(location)
    if @board[location] != " " && @board[location] != ""
      puts "That space is already taken."
      true
    else
      false
    end
  end

  def valid_move?(index)
    if index.between?(0,8)
      !position_taken?(index)
    else
      puts "That space is not on the board."
      false
    end
  end

  def turn
    puts "Where would you like to go? (enter 1-9)"
    input = gets.strip
    index = input_to_index(input)

    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    turns = @board.reject{|space| space == " " || space == ""}
    turns.count
  end

  def current_player
    turn_count.even? ? "X" : "O"
  end

  def won?
    win_array = WIN_COMBINATIONS.select do |win_combo|
      win_combo.all? { |win_index| @board[win_index] == "X"} ||
      win_combo.all? { |win_index| @board[win_index] == "O"}
    end
    win_array[0]
  end

  def full?
    !@board.any? { |space| space == " " || space == ""}
  end

  def draw?
    full? && !won?
  end

  def over?
    full? || won? || draw?
  end

  def winner
    @board[won?[0]] if won?
  end

  def play
    until over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    else
      current_player
    end
  end
end
