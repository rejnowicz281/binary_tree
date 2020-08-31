class Node 
  attr_accessor :root, :left, :right

  def initialize(root, left = nil, right = nil) 
    @root = root 
    @left = left 
    @right = right
  end

  def has_only_one_child?
    (left != nil && right == nil) || (left == nil && right != nil)
  end

  def has_no_children?
    left == nil && right == nil
  end 

  def has_two_children?
    left != nil && right != nil 
  end

  def has_left?
    left != nil 
  end 

  def has_only_left? 
    left != nil && right == nil 
  end 

  def has_no_left? 
    left == nil 
  end 

  def has_right?
    right != nil 
  end 

  def has_only_right?
    right != nil && left == nil
  end 

  def has_no_right? 
    right == nil
  end   

  def only_child 
    if has_only_one_child? 
      if has_left? 
        left 
      elsif has_right? 
        right
      end 
    end 
  end 
end