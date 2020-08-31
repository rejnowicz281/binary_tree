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
end 