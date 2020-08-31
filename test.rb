require_relative "tree.rb"
require_relative "node.rb"

my_tree = Tree.new(Array.new(15) { rand(1..100) })

my_tree.pretty_print