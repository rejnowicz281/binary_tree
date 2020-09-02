require_relative "tree.rb"
require_relative "node.rb"

puts "--build and print tree--"
my_tree = Tree.new(Array.new(15) { rand(1..100) })
my_tree.pretty_print

puts
puts "--balanced?--"
p my_tree.balanced?

puts 
puts "--level, pre, in, post order--"
p my_tree.level_order
my_tree.preorder; puts 
my_tree.inorder; puts 
my_tree.postorder; puts

puts 
puts "--unbalancing the tree--"
my_tree.insert(102)
my_tree.insert(103)
my_tree.insert(105)
my_tree.delete_root

my_tree.pretty_print

p my_tree.balanced?

puts 
puts "--rebalancing the tree--"
my_tree.rebalance 

my_tree.pretty_print

p my_tree.balanced?

puts 
puts "--level, pre, in, post order"
p my_tree.level_order
my_tree.preorder; puts 
my_tree.inorder; puts 
my_tree.postorder; puts