require_relative 'tree_node'

def build_move_tree(start_pos)
  root_node = PolyTreeNode.new(start_pos)

  visited_squares = [start_pos]

  nodes = [root_node]
  until nodes.empty?
    current_node = nodes.shift

    current_pos = current_node.value
    valid_moves(current_pos).each do |next_pos|
      next if visited_squares.include?(next_pos)

      next_node = PolyTreeNode.new(next_pos)
      current_node.add_child(next_node)

      visited_squares << next_pos
      nodes << next_node
    end
  end

  root_node
end

MOVES = [
  [-2, -1],
  [-2,  1],
  [-1, -2],
  [-1,  2],
  [ 1, -2],
  [ 1,  2],
  [ 2, -1],
  [ 2,  1]
]

def valid_moves(start_pos)
  valid_moves = []

  cur_x, cur_y = start_pos
  MOVES.each do |(dx, dy)|
    new_pos = [cur_x + dx, cur_y + dy]

    if new_pos.all? { |coord| coord.between?(0, 7) }
      valid_moves << new_pos
    end
  end

  valid_moves
end

def build_path(node)
  moves = []

  current_node = node
  until current_node.nil?
    moves << current_node.value

    current_node = current_node.parent
  end

  moves.reverse
end

def find_path(start_pos, end_pos)
  move_tree = build_move_tree(start_pos)
  end_node = move_tree.bfs(end_pos)
  build_path(end_node)
end

if __FILE__ == $PROGRAM_NAME
  p find_path([0, 0], [7, 7])
end
