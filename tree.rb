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
end 