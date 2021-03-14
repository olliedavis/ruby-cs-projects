class Node
  attr_accessor :position, :parent, :children

  def initialize(position, parent = nil, children = nil)
    @position = position
    @parent = parent
    @children = children
  end
end
