class Node
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Knight
  attr_reader :moves

  def initialize
    @moves = [[-2, -1], [-1, -2], [-2, 1], [-1, 2], [1, -2], [2, -1], [1, 2], [2, 1]]
  end
end