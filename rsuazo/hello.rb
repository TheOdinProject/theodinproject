class GameBoard
  def initialize
  end
end

class Knight
  attr_accessor: position

  def initialize(x_coordinate = 0, y_coordinate = 0)
    @position = (x_coordinate, y_coordinate)
  end
end