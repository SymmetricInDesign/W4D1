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
    

end
# i = -2
# p i.abs
# p i
# p 3.between?(0,3)
# p KnightPathFinder.valid_moves([2,6])

knight =     KnightPathFinder.new([4,4])
knight.build_move_tree
p knight.considered_positions
p knight.root_node.to_s