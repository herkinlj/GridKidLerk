class Grid
  def initialize
    @cells = {}
  end

  def set_value_at(row, col, expression)
    @cells[[row, col]] = expression
  end

  def get_value_at(row, col)
    @cells[[row, col]] || raise("Cell at [#{row},#{col}] not defined")
  end
end
