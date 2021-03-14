require_relative 'knight'
require_relative 'node'
require_relative 'board'
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