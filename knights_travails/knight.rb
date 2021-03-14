require_relative 'board'
class Knight
  def self.possible_moves(current_position)
    x = current_position[0]
    y = current_position[1]
    possible_moves = [
      [x - 2, y - 1], [x - 1, y - 2], [x - 2, y + 1], [x - 1, y + 2],
      [x + 1, y - 2], [x + 2, y - 1], [x + 1, y + 2], [x + 2, y + 1]
    ]
    valid_moves(possible_moves)
  end

  def self.valid_moves(possible_moves)
    valid_moves = []
    possible_moves.each do |move|
      valid_moves << move if Chessboard.allowed?(move)
    end
    valid_moves
  end
end