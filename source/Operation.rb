class Operation
  attr_accessor :operand_one, :operand_two

  def initialize(operand_one, operand_two)
    @operand_one = operand_one
    @operand_two = operand_two
  end
end

class Addition < Operation
  def evaluate(environment)
    left = @operand_one.evaluate(environment)
    right = @operand_two.evaluate(environment)
    if left == :float && right == :float
      FloatPrimitive.new(left.value + right.value)
    elsif left == :integer && right == :integer
      IntegerPrimitive.new(left.value + right.value)
    end
  end
end