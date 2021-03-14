class Node
  attr_accessor :position, :parent, :children

  def initialize(position, parent = nil, children = nil)
    @position = position
    @parent = parent
    @children = children
  end
end

class Knight
  def self.possible_moves(current_position)
    x = current_position[0]
    y = current_position[1]
    possible_moves = [
      [x - 2, y - 1], [x - 1, y - 2], [x - 2, y + 1], [x - 1, y + 2],
      [x + 1, y - 2], [x + 2, y - 1], [x + 1, y + 2], [x + 2, y + 1]
    ]
    valid_moves(possible_moves)
  end

  def valid_moves(possible_moves)
    valid_moves = []
    possible_moves.each do |move|
      valid_moves << move if Chessboard.allowed?(move)
    end
  end
  valid_moves
end

class Chessboard
  def board
    @board_squares= []
    (0..7).each do |i|
      (0..7).each do |x|
        board_squares << [i, x] # creates board array with sub arrays for each position
      end
    end
  end

  def self.allowed?(move)
    board # creates the board
    return true unless @board_squares.any?(move) # returns true if the move is within the board.

    false # else returns false
  end
end

class Path
  def initialize(start_position, end_position)
    @start_position = start_position
    @end_position = end_position
    @finish = false
    find_path
  end

  def find_path
    @queue = []
    current = Node.new(@start_position)
    @queue << current

    until @queue.empty? || @finish
      get_children(current)
      check_children(current) # TODO
      current = queue.shift
    end
  end

  def get_children(current)
    children = []
    children_nodes = []
    children << Knight.valid_moves(current.position) # inputs all the valid moves into the children array
    children.each { |child| children_nodes << Node.new(child, current) } # creates a new node for each child and set the current node as the parent
    current.children = children_nodes # sets the created nodes as the parents children
  end
end
