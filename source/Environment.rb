class Environment
  def initialize(grid)
    @grid = grid
  end

  def get_value_at(row, col)
    @grid.get_value_at(row, col).evaluate(self)
  end
end
