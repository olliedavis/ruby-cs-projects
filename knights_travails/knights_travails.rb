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

  def self.valid_moves(possible_moves)
    valid_moves = []
    possible_moves.each do |move|
      valid_moves << move if Chessboard.allowed?(move)
    end
    valid_moves
  end
end

class Chessboard
  attr_reader :board_squares

  @board_squares = []
  def self.board
    (0..7).each do |i|
      (0..7).each do |x|
        @board_squares << [i, x] # creates board array with sub arrays for each position
      end
    end
    @board_squares
  end

  def self.allowed?(move)
    return true if @board_squares.any?(move) # returns true if the move is within the board.

    false # else returns false
  end
end

class Path
  def initialize(start_position, end_position)
    @start_position = start_position
    @end_position = end_position
    Chessboard.board # creates the chessboard
    find_path
  end

  def find_path
    @queue = []
    current = Node.new(@start_position)
    @queue << current

    until @queue.empty?
      get_children(current) # gets all the valid children and sets them as the current nodes children
      check_children(current) # checks the children of the current node to see if matches the end position
      current = @queue.shift # sets a child to the current node and repeats
    end
  end

  def get_children(current)
    children = []
    children_nodes = []
    children << Knight.possible_moves(current.position) # inputs all the possible moves into the children array
    children.flatten!(1)
    # creates a new node for each child and set the current node as the parent
    children.each { |child| children_nodes << Node.new(child, current) }
    current.children = children_nodes # sets the created nodes as the parents children
  end

  def check_children(current)
    current.children.each do |child|
      if child.position == @end_position
        found(current)
      else
        @queue << child
      end
    end
  end

  def found(current)
    move_count = 1
    final_path = [current.position]
    until current.parent.nil? # iteratates through childs ancestors
      move_count += 1 # increments the move counter
      final_path.unshift(current.parent.position) # puts each parents's position in the final path array
      current = current.parent
    end
    final_path << @end_position
    finished(move_count, final_path)
  end

  def finished(move_count, final_path)
    puts ''
    puts "The Knight can move from #{@start_position} to #{@end_position} in #{move_count} moves!"
    puts 'This is the path it took:'
    final_path_display(final_path)
    puts ''
    exit
  end

  def final_path_display(final_path)
    array = []
    final_path.each do |pos|
      array.push("[#{pos[0]}, #{pos[1]}]")
      array.push([' --> ']) if pos != @end_position
    end
    puts array.join
  end
end

Path.new([0, 0], [7, 7])