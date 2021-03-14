class Chessboard
  attr_reader :board_squares

  @board_squares = []
  def self.board
    (0..7).each do |i|
      (0..7).each do |x|
        @board_squares << [i, x] # creates board array with sub arrays for each position
      end
    end
    @board_squares
  end

  def self.allowed?(move)
    return true if @board_squares.any?(move) # returns true if the move is within the board.

    false # else returns false
  end
end