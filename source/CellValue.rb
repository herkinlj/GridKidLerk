class CellValue
  attr_reader :row, :column

  def initialize(row, column)
    @row, @column = row, column
  end

  def to_s
    "[#{@row},#{@column}]"
  end
end

class CellLValue < CellValue; end
class CellRValue < CellValue
  def evaluate(environment)
    environment.get_value_at(@row, @column)
  end
end
