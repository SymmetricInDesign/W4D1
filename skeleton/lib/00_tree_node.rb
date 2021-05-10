require "byebug"

class PolyTreeNode

    attr_reader :parent, :children, :value 
    attr_writer :parent

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node)
        if node == nil 
            @parent = nil 
            return
        end

        if @parent != nil
            # debugger
            @parent.children.delete(self)
            # p @parent
        end
        
        @parent = node
        
        @parent.children << self if !@parent.children.include?(self)
    end

    def add_child(child_node)
        if !@children.include?(child_node) && !child_node.parent
            child_node.parent = self 
        end
    end

    def remove_child(child_node)
        if child_node.parent == nil
            raise "Node is not a child"
        end

        child_node.parent = nil
        @children.delete(child_node)
        
    end

    def dfs(target_value)
        return self if @value == target_value
        
        # root is self
        if !@children.empty?
            @children.each do |child|
                child = child.dfs(target_value)
                return child if child != nil
            end
        end
        nil
    end


    def bfs(target_value)
        queue = []
        queue << self
        until queue.empty?
            node = queue.shift
            return node if node.value == target_value
            node.children.each {|child| queue << child} 
        end
        nil
    end

    # def to_s
    #     @value
    # end
    

end

=begin
            1
    2               5
3       4       6       7
=end


=begin

self: value = 1, parent = nil, children = [2,5]

child: value = 2, parent = 1, children = [3,4]
child: value = 5, parent = 1, children = [6,7]

child: value = 3, parent = 2, children = []
child: value = 4, parent = 2, children = []
child: value = 6, parent = 5, children = []
child: value = 7, parent = 5, children = []

dfs(target_value = 3)
    stack 1: node 2
        dfs(node 2)
    stack 2:
        node 3


=end



# node1 = PolyTreeNode.new('root')
# node2 = PolyTreeNode.new('child1')
# node3 = PolyTreeNode.new('child2')

# p node2.inspect
# p node2.object_id
# node2.add_child(node3)
# p node2.inspect
# p node2.object_id
# node2.add_child(node3)
