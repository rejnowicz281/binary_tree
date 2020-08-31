require_relative "node.rb"

class Tree 
  attr_reader :root_node

  def initialize(array)
    if array.empty?
      @root_node = nil
    else
      @array = array.uniq.sort
      @root_node = build_tree(@array, 0, @array.length - 1)
    end 
  end

  def build_tree(array, start, ennd)
    return nil if start > ennd
    mid = (start + ennd)/2
    Node.new(array[mid], build_tree(array, start, mid - 1), build_tree(array, mid + 1, ennd))
  end

  def pretty_print(node = @root_node, prefix = '', is_left = true)
    return puts "nil" if @root_node == nil
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.root}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def find(value, find_parent = false)
    return if value == nil 

    begin
      current = @root_node
      loop do 
        if value > current.root 
          if current.right.root == value
            return current if find_parent == true 
            return current.right
          else
            current = current.right
          end
        else
          if current.left.root == value
            return current if find_parent == true
            return current.left
          else
            current = current.left 
          end 
        end 
      end 
    rescue 
      false
    end 
  end 

  def node_exists?(value)
    begin 
      find(value).root == value
    rescue 
      false
    end 
  end    

  def insert(value)
    return puts "Can't insert strings." if value.is_a? String || value == false || value == true || value == nil
    return @root_node = Node.new(value) if @root_node == nil
    return puts "Can't insert duplicates. #{value} already in the tree." if node_exists?(value) || @root_node.root == value

    current = @root_node
    loop do 
      if value > current.root
        break if current.right == nil 
        current = current.right 
      else
        break if current.left == nil
        current = current.left
      end
    end
    
    current.left = Node.new(value)  if value < current.root
    current.right = Node.new(value) if value > current.root
  end

  def delete_root 
    if @root_node == nil 
      return puts "Root node doesn't exist."
    elsif @root_node.has_no_children?
      @root_node = nil
    elsif @root_node.has_only_one_child?
      @root_node = @root_node.only_child
    elsif @root_node.has_two_children?
      if @root_node.right.has_left?
        current = @root_node.right.left

        current = current.left until current.has_no_left?

        copy = current.root 
        delete(copy)
        @root_node.root = copy 
      elsif @root_node.right.has_no_children? || @root_node.right.has_only_right?
        copy = @root_node.right.root 
        delete(copy)
        @root_node.root = copy
      end 
    end 
  end 

  def delete(value)
    return if value.is_a? String || value == false || value == true || value == nil
    return puts "Can't delete, root node doesn't exist." if @root_node == nil 
    return delete_root if @root_node.root == value
    return puts "Can't delete #{value}, doesn't exist in the tree." unless node_exists?(value)

    node_with_value = find(value)
    parent_node = find(value, find_parent = true)
    
    if node_with_value.has_no_children?
      parent_node.left = nil  if parent_node.left == node_with_value
      parent_node.right = nil if parent_node.right == node_with_value
    elsif node_with_value.has_only_one_child?
      parent_node.left = node_with_value.only_child  if parent_node.left == node_with_value
      parent_node.right = node_with_value.only_child if parent_node.right == node_with_value
    elsif node_with_value.has_two_children?
      if node_with_value.right.has_left?
          current = node_with_value.right.left 

          current = current.left until current.has_no_left?

          copy = current.root 
          delete(copy)
          parent_node.right.root = copy if parent_node.right.root == value 
          parent_node.left.root = copy  if parent_node.left.root == value 
      elsif node_with_value.right.has_no_children? || node_with_value.right.has_only_right?
        copy = node_with_value.right.root 
        delete(copy)
        parent_node.right.root = copy if parent_node.right.root == value
        parent_node.left.root = copy  if parent_node.left.root == value
      end 
    end 
  end

  def level_order
    queue = [@root_node]
    traversed = []

    until queue == []
      if queue[0].has_no_children?
        traversed << queue[0].root 
        queue.shift
      elsif queue[0].has_only_one_child?
        queue.push(queue[0].only_child)
        traversed << queue[0].root 
        queue.shift
      elsif queue[0].has_two_children?
        queue.push(queue[0].left)
        queue.push(queue[0].right)
        traversed << queue[0].root
        queue.shift
      end 
    end

    traversed
  end 

  def inorder(node = @root_node)
    return if node == nil 
    inorder(node.left)
    print "#{node.root} " 
    inorder(node.right)
  end 

  def preorder(node = @root_node)
    return if node == nil
    print "#{node.root} "  
    preorder(node.left)
    preorder(node.right)
  end 

  def postorder(node = @root_node)
    return if node == nil 
    postorder(node.left)
    postorder(node.right)
    print "#{node.root} " 
  end 
end