WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
  # ETC, an array for each win combination
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move (board, pos, char)
  board[pos] = char
end

def position_taken? (board, index)
  if board[index] == " "
    return false
  elsif board[index] == ""
    return false
  elsif board[index] == nil
    return false
  elsif board[index] == "X"
    return true
  elsif board[index] == "O"
    return true
  end
end

def valid_move?(board, input)
  if input.between?(0, 8) && !(position_taken?(board, input))
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  input = input_to_index(input)
  if valid_move?(board, input) == true
      move(board, input, current_player(board))
      display_board(board)
  else
      puts "That is an invalid entry!"
      turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |i|
    count += 1 if i == "X" || i == "O"
  end
  return count
end

def current_player(board)
  turn_num = turn_count(board) + 1
  if turn_num.even? == true
    return "O"
  else
    return "X"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |array|
      win_index_1 = array[0]
      win_index_2 = array[1]
      win_index_3 = array[2]
      position_1 = board[win_index_1] # load the value of the board at win_index_1
      position_2 = board[win_index_2] # load the value of the board at win_index_2
      position_3 = board[win_index_3] # load the value of the board at win_index_3

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return array # return the win_combination indexes that won.
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return array
      else
        false
      end
  end
end

def full?(board)
  board.none?{|cell| cell == " "}
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if !won?(board)
    return nil
  else
    return board[won?(board)[0]]
  end
end

def play(board)
  while over?(board) == false && draw?(board) == false
    turn(board)
  end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
