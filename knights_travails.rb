class Node
  attr_accessor :position, :parent, :children

  def initialize(position, parent = nil, children = nil)
    @position = position
    @children = children
    @parent = parent
  end
end

class Knight
  def self.moves
    [[-2, -1], [-1, -2], [-2, 1], [-1, 2], [1, -2], [2, -1], [1, 2], [2, 1]]
  end
end

class Chessboard
  def self.board
    [[''] * 8] * 8
  end
end

class Tree
  def initialize
    @moves = Knight.moves
    @root = build_tree(@moves)
  end
end