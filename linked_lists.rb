class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value # variable to be filled in with a value of whataever.
    @next_node = next_node # variable to be filled in with next node in the linked list
  end
end

class LinkedList
  attr_reader :head

  def initialize
    @head = nil # creates an empty list with no nodes.
  end

  def append(value)
    if @head.nil?
      @head = Node.new(value) # if the link list head is empty, set the new node to be the head
    else
      node = @head # point the node to the head of the list
      node.next_node until node.next_node.nil? #  keeps moving moving through the linked list to the next node until there is no next_node
      node.next_node = Node.new(value) # sets the last node to new node.
    end
  end

  def prepend(value)
    @head = @head.nil? ? Node.new(value) : Node.new(value, @head)
  end

  def size
    node = @head
    length = 0
    return 0 if node.nil?

    length += 1 until node.next_node.nil?
  end

  def tail
    node = @head
    node.next_node until node.next_node.nil?
    node
  end

  def at(index)
    node = @head
    return @head if index.nil?

    index.times do
      node = node.next_node
    end
  end

  def pop
    node = @head
    return nil if node.nil?

    node.next_node until node.next_node.nil?
    node.value = nil
  end

  def contains?(value)
    node = @head
    return true if node.value == value until node.next_node.nil?

    false
  end

  def find(value)
    index = 0
    node = @head
    return 0 if node.value == value

    until node.next_node.nil?
      index += 1
      return index if node.value == value
    end

    nil
  end

  def to_s
    string_array = []
    node = @head
    if node.next_node.nil?
      string_array << "( #{node.value} ) -> nil"
    else
      string_array << "( #{node.value} ) -> " until node.next_node.nil?
    end
    puts string_array.flatten
  end

  def insert_at(value, index)
    node = @head
    return @head = value if node.next_node.nil?

    (index - 1).times do 
      node.next_node
    end
    node.next_node = Node.new(value, next_node)
  end

  def remove_at(index)
    node = @head

    return node.next_node = @head if index.nil?

    index.times do
      node.next_node
    end

    new_next_node = node.next_node
    node = @head

    (index - 1).times do
      node.next_node
    end
    node.next_node = new_next_node
  end
end
