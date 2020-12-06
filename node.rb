class Node 
    attr_accessor :data, :left, :right 

    def initialize(data,left = nil,right = nil)
        @data = data
        @left = left 
        @right = right
    end 

    def is_leaf_node?
        left == nil && right == nil
    end 

    def has_only_right?
        left == nil && right != nil
    end 

    def has_only_left?
        left != nil && right == nil 
    end 

    def only_child 
        has_only_right? ? right : has_only_left? ? left : return
    end 

    def has_left?
        left != nil
    end 

    def has_right? 
        right != nil
    end 
end     