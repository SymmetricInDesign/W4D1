require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    @child_nodes = []
    @parent_nodes = nil
  end

  def add_child(node)
    node.parent=self
    @child_nodes << node
  end

  def populate_tree
    board_full = true
    @board.rows.each_with_index do |row, i|
      row.each_with_index {|space, j| board_full = false if @board.empty?([i,j])}
    end
    return if board_full
    children = self.children
    children.each {|child| self.add_child(child)}
    @child_nodes.each do |child|
      child.populate_tree
    end
    
  end

  def losing_node?(evaluator)


  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    @board.rows.each_with_index do |row, i|
      row.each_with_index do |space, j|
        new_board = @board.dup
        if new_board.empty?([i,j])
          new_board[[i,j]] = @next_mover_mark
          next_next_mover_mark = :o if @next_mover_mark == :x
          next_next_mover_mark = :x if @next_mover_mark == :o
          children << TicTacToeNode.new(new_board, next_next_mover_mark, [i,j])
        end
      end
    end
    children
  end

end
