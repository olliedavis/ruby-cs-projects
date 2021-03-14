class Node
  attr_accessor :position, :parent, :children

  def initialize(position, parent = nil, children = nil)
    @position = position
    @children = children
    @parent = parent
  end
end

class Knight
  def initialize(current_position = [0,0])
    @current_position = current_position
  end

  def valid_moves
    x = @current_position[0]
    y = @current_position[1]
    possible_moves = [
      [x - 2, y - 1], [x - 1, y - 2], [x - 2, y + 1], [x - 1, y + 2],
      [x + 1, y - 2], [x + 2, y - 1], [x + 1, y + 2], [x + 2, y + 1]
    ]
  end
end

class Chessboard
  def board
    @board_squares= []
    (0..7).each do |i|
      (0..7).each do |x|
        board_squares << [i, x]
      end
    end
  end

  def self.allowed?(move)
    return true unless @board_squares != move

    false
  end
end

class Tree
  def initialize
    @moves = Knight.moves
    @root = build_tree(@moves)
  end
end
