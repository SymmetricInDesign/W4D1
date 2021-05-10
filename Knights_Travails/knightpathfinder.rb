require_relative "../skeleton/lib/00_tree_node.rb"
require "byebug"

class KnightPathFinder

    attr_reader :considered_positions, :root_node

    def self.valid_moves(pos)
        x, y = pos
        valid_moves = []
        i = -2
        j = -2
        while i <= 2
            if i == 0
                i += 1
                next
            end
            while j <= 2
                if j == 0
                    j += 1
                    next
                end
                if (i.abs == 2 && j.abs == 2) || (i.abs==1 && j.abs == 1)
                    j += 1
                    next 
                end
                if (x+i).between?(0,7) && (y+j).between?(0,7)
                    valid_moves << [x + i, y + j] 
                end
                j += 1
            end
            i += 1
            j= -2
        end
        valid_moves
    end

    def initialize(pos)
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = [pos]
    end

    def new_move_positions(pos)
        positions = KnightPathFinder.valid_moves(pos).reject { |move| @considered_positions.include?(move) }
        @considered_positions += positions
        positions
    end

    def build_move_tree
        queue = []
        queue << @root_node
        until queue.empty?
            node = queue.shift
            new_move_positions(node.value).each { |pos| node.add_child(PolyTreeNode.new(pos)) }
            node.children.each { |child| queue << child }
        end
    end

    # def bfs(target_value)
    #     queue = []
    #     queue << self
    #     until queue.empty?
    #         node = queue.shift
    #         return node if node.value == target_value
    #         node.children.each {|child| queue << child} 
    #     end
    #     nil
    # end

    def find_path(end_pos)
        trace_path_back(@root_node.dfs(end_pos))
    end
    
    def trace_path_back(node)
        path = [node.value]
        return path if !node.parent
        trace_path_back(node.parent).concat(path)
    end

end
# i = -2
# p i.abs
# p i
# p 3.between?(0,3)
# p KnightPathFinder.valid_moves([2,6])

<<<<<<< HEAD
knight =     KnightPathFinder.new([4,4])
knight.build_move_tree
p knight.considered_positions
p knight.root_node.to_s
=======
# knight =     KnightPathFinder.new([4,4])
# knight.build_move_tree
# p knight.considered_positions.length
# p knight.root_node.to_s

kpf = KnightPathFinder.new([0, 0])
kpf.build_move_tree
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
>>>>>>> f3271b04a2a37b77dc2064b6ea8f57e59550313a
