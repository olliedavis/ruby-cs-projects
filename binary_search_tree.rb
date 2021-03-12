class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :root, :data

  def initialize(array)
    @data = array
    @root = build_tree(data)
  end

  def build_tree(array)
    return nil if array.empty? # repeats recursively until array is empty
    arr = array.sort.uniq

    mid = (arr.size - 1) / 2 # returns the middle index
    root_node = Node.new(arr[mid]) # creates a root node from the middle index
    root_node.left = build_tree(arr[0...mid]) # creates a left subtree from the left half of the array
    root_node.right = build_tree(arr[(mid + 1)..-1]) # creates a right subtree from the right half of the array
    root_node
  end

  def insert(value, node = root)
    return nil if value == node.data # return nil if a new value isn't parsed

    # if the new value is less than the root value, 
    # check if it there is another node to the left, if not, add the new value there
    # if there is , loop the above until there is not.
    # vice versa if the new value is greater than the root value
    if value < node.data
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    elsif value > node.data
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  def delete(value, node = root)
    return node if node.nil?

    if value > node.data # if the value is more than the root node, start cascading down the right
      node.right = delete(value, node.right)
    elsif value < node.data # if the value is more than the root node, start cascading down the left
      node.left = delete(value, node.left)
    else
      return node.right if node.left.nil? # if the value is more than the root node
      return node.left if node.right.nil? # if the node has a right child but not a left child, delete the node and connect the right child to parent node

      # if the node has two leaves, find the left most node/leaf and connect it the leaves to parent node, then delete the node
      left_most_node = find_min_value_node(node.right)
      node.data = left_most_node.data
      node.right = delete(left_most_node.data, node.right)
    end
    node
  end

  def find_min_value_node(node)
    node.left until node.left.nil?
    node
  end

  def find(value, node = root)
    return node if node.data == value || node.nil?

    puts "value: #{value}"
    puts "data: #{node.data}"
    value < node.data ? find(value, node.left) : find(value, node.right)
  end

  def level_order(node = root)
    queue = [] # temporary queue
    data = [] # final array
    queue << node # push the initial root_node into the que
    until queue.empty? # keep running until queue is empty. If the queue is empty, there are no nodes left
      temp = queue.shift # takes the first node in the queue
      queue << temp.left if temp.left # add the left child node of the current node we pulled from the queue to the queue
      queue << temp.right if temp.right # add the right child node of the node we pulled from the queue to the queue
      data << temp.data # push the node to array and repeat
    end
    data # return the data array
  end

  # The left subtree is traversed first, then works its way up, pushing each node and it's children, then pushing the root node.
  # Then traverses the right subtree, then works its way back up, pushing each node and it's children.
  def in_order(node = root, array = [])
    return if node.nil?

    in_order(node.left, array) # traverse the whole left tree first
    array << node.data # then push the node into the array when it reaches the leaf node
    in_order(node.right, array) # then traverse the whole right tree
    array
  end

  # Pushes the root node, then traverse the whole left subtree then the right subtree, pushing each node as it passes through
  def pre_order(node = root, array = [])
    return if node.nil?

    array << node.data
    pre_order(node.left, array)
    pre_order(node.right, array)
    array
  end

  # Traverses the whole left tree, pushing the child nodes then pushing the parent nodes
  # Then traverses whole right tree, pushing the child nodes then pushing parent nodes
  # Finally, pushed the root node
  def post_order(node = root, array = [])
    return if node.nil?

    post_order(node.left, array)
    post_order(node.right, array)
    array << node.data
  end

  def height(node = root)
    return -1 if node.nil?

    [height(node.left), height(node.right)].max + 1
  end

  def depth(value, node = root)
    depth = 0
    temp_node = node
    until temp_node == value
      temp_node = temp_node.data > value ? temp_node.left : temp_node.right
      depth += 1
    end
    depth
  end

  def balanced?(node = root)
    root_left_depth = height(node.left)
    root_right_depth = height(node.right)
    diff = root_left_depth - root_right_depth
    diff > -2 && diff < 2
  end

  def rebalance
    self.data = level_order
    self.root = build_tree(data)
  end
end

def script
  array = Array.new(15) { rand(1..100) }
  tree = Tree.new(array)
  puts tree.balanced? ? 'The tree is balanced' : 'The tree is not balanced'
  puts "Level Order: #{tree.level_order}"
  puts "In Order: #{tree.in_order}"
  puts "Post Order: #{tree.post_order}"
  puts "Pre Order #{tree.pre_order}"
  puts 'inserting nodes 120, 145, 150, and 154 to tree to unbalance it'
  tree.insert(120)
  tree.insert(145)
  tree.insert(150)
  tree.insert(154)
  puts 'testing..'
  puts tree.balanced? ? 'The tree is still balanced' : 'The tree is no longer balanced'
  puts 'rebalancing..'
  tree.rebalance
  puts tree.balanced? ? 'The tree is balanced again' : 'The tree is still not balanced'
  puts "Level Order: #{tree.level_order}"
  puts "In Order: #{tree.in_order}"
  puts "Post Order: #{tree.post_order}"
  puts "Pre Order #{tree.pre_order}"
  puts "deleting 145"
  tree.delete(145)
  tree.rebalance
  puts tree.in_order.any?(145) ? '145 still exists' : '145 removed'  
end

script