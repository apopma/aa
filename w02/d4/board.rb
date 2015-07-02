require_relative 'empty_square'
require_relative 'piece'

class Board
  attr_accessor :grid

  def initialize
    @blank = EmptySquare.new
    @grid = Array.new(8) { Array.new(8) { @blank } }
  end

  def setup
    setup_odd_row(0, :red)
    setup_even_row(1, :red)
    setup_odd_row(2, :red)

    setup_even_row(5, :black)
    setup_odd_row(6, :black)
    setup_even_row(7, :black)
  end

  def remove_piece(pos)
    self[pos] = @blank
  end

  def render
    system("clear")
    grid.each_with_index do |row, ridx|
      row.each_with_index do |elem, cidx|
        print_elem(elem, ridx, cidx)
      end
      puts
    end
  end

  def print_elem(elem, ridx, cidx)
    #copied over from chess
    square = " #{elem.to_s} "

    if (ridx + cidx) % 2 == 0
      print square.on_light_red
    else
      print square.on_light_black
    end
  end

  def dup
    duped_board = Board.new

    grid.each_with_index do |row, ridx|
      row.each_with_index do |square, cidx|
        duped_pos = [ridx, cidx]
        duped_board[duped_pos] = square.dup(duped_board)
      end
    end
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    grid[row][col] = piece
  end

  private
  def setup_odd_row(row, color)
    cols = [1, 3, 5, 7]
    cols.each { |col| grid[row][col] = Piece.new([row, col], self, color) }
  end

  def setup_even_row(row, color)
    cols = [0, 2, 4, 6]
    cols.each { |col| grid[row][col] = Piece.new([row, col], self, color) }
  end
end

b = Board.new
b.setup
p1 = b[[2, 1]]
p2 = b[[5, 2]]

p1.perform_slide([3, 0])
p2.perform_slide([4, 1])
b.render
sleep(0.5)

b[[3, 0]].perform_jump([5, 2])
b.render

sleep(0.5)
b[[0, 1]].king_me!
b.render
puts b[[0, 1]].inspect
