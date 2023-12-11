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
    if left == :float || right == :float
      FloatPrimitive.new(left.value + right.value)
    elsif left == :int && right == :int
      IntegerPrimitive.new(left.value + right.value)
    else
      raise RuntimeError.new("Cannot add #{left} and #{right}.  Operands must be of type Integer or Float")
    end
  end
end

class Subtraction < Operation
  def evaluate(environment)
    left = @operand_one.evaluate(environment)
    right = @operand_two.evaluate(environment)
    if left == :float || right == :float
      FloatPrimitive.new(left.value - right.value)
    elsif left == :int && right == :int
      IntegerPrimitive.new(left.value - right.value)
    else
      raise RuntimeError.new("Cannot subtract #{left} and #{right}.  Operands must be of type Integer or Float")
    end
  end
end

class Divide < Operation
  def evaluate(environment)
    left = @operand_one.evaluate(environment)
    right = @operand_two.evaluate(environment)
    if left == 0.0 || right == 0.0
      raise RuntimeError.new("Cannot divide by 0")
    end
    if left == :float || right == :float
      FloatPrimitive.new(left.value / right.value)
    elsif left == :int && right == :int
    else
      raise RuntimeError.new("Cannot divide #{left} and #{right}.  Operands must be of type Integer or Float")
    end
  end
end

class Multiply < Operation
  def evaluate(environment)
    left = @operand_one.evaluate(environment)
    right = @operand_two.evaluate(environment)
    if left == :float || right == :float
      FloatPrimitive.new(left.value * right.value)
    elsif left == :int && right == :int
      IntegerPrimitive.new(left.value * right.value)
    else
      raise RuntimeError.new("Cannot multiply #{left} and #{left}.  Operands must be of type Integer or Float")
    end
  end
end

class Modulus < Operation
  def evaluate(environment)
    left = @operand_one.evaluate(environment)
    right = @operand_two.evaluate(environment)
    if left == :float || right == :float
      FloatPrimitive.new(left.value % right.value)

    elsif left == :int && right == :int
      IntegerPrimitive.new(left.value % right.value)
    else
      raise RuntimeError.new("Cannot mod #{left} and #{right}.  Operands must be of type Integer or Float")
    end
  end
end

class Exponent < Operation
  def evaluate(environment)
    left = @operand_one.evaluate(environment)
    right = @operand_two.evaluate(environment)
    if left == :float || right == :float
      FloatPrimitive.new(left.value ** right.value)
    elsif left == :int && right == :int
      IntegerPrimitive.new(left.value ** right.value)
    else
      raise RuntimeError.new("Cannot exponentiate #{left} and #{right}.  Operands must be of type Integer or Float")
    end
  end
end

class BitwiseAnd < Operation
  def evaluate(environment)
    left = @operand_one.evaluate(environment)
    right = @operand_two.evaluate(environment)
    if left == :int && right == :int
      IntegerPrimitive.new(left.value & right.value)
    else
      raise RuntimeError.new("Cannot bitwise and #{left} and #{right}.  Both operands must be of type Integer")
    end
  end
end

class BitwiseOr < Operation
  def evaluate(environment)
    left = @operand_one.evaluate(environment)
    right = @operand_two.evaluate(environment)
    if left == :int && right == :int
      IntegerPrimitive.new(left.value | right.value)
    else
      raise runtime_error("Cannot bitwise or #{left} and #{right}.  Both operands must be of type Integer")
    end
  end
end

class BitwiseXor < Operation
  def evaluate(environment)
    left = @operand_one.evaluate(environment)
    right = @operand_two.evaluate(environment)
    if left == :int && right == :int
      IntegerPrimitive.new(left.value ^ right.value)
    else
      raise RuntimeError.new("Cannot bitwise xor #{left} and #{right}.  Both operands must be of type Integer")
    end
  end
end

class BitwiseLeftShift < Operation
  def evaluate(environment)
    left = @operand_one.evaluate(environment)
    right = @operand_two.evaluate(environment)
    if left == :int && right == :int
      IntegerPrimitive.new(left.value << right.value)
    else
      raise RuntimeError.new("Cannot bitwise left shift #{left} and #{right}.  Both operands must be of type Integer")
    end
  end
end

class BitwiseRightShift < Operation
  def evaluate(environment)
    left = @operand_one.evaluate(environment)
    right = @operand_two.evaluate(environment)
    if left == :int && right == :int
      IntegerPrimitive.new(left.value >> right.value)
    else
      raise RuntimeError.new("Cannot bitwise right shift #{left} and #{right}.  Both operands must be of type Integer")
    end
  end
end

class LessThan < Operation
  def evaluate(environment)
    left = @operand_one.evaluate(environment)
    right = @operand_two.evaluate(environment)
    if (left == :int || left == :float) && (right == :int || right == :float)
      BooleanPrimitive.new(left.value < right.value)
    else
      raise RuntimeError.new("Cannot compare #{left} and #{right}.  Operands must be of type Integer or Float")
    end
  end
end

class GreaterThan < Operation
  def evaluate(environment)
    left = @operand_one.evaluate(environment)
    right = @operand_two.evaluate(environment)
    if (left == :int || left == :float) && (right == :int || right == :float)
      BooleanPrimitive.new(left.value > right.value)
    else
      raise RuntimeError.new("Cannot compare #{left} and #{right}.  Operands must be of type Integer or Float")
    end
  end
end

class GreaterThanOrEqualTo < GreaterThan
  def evaluate(environment)
    left = @operand_one.evaluate(environment)
    right = @operand_two.evaluate(environment)
    if (left == :int || left == :float) && (right == :int || right == :float)
      BooleanPrimitive.new(left.value >= right.value)
    else
      raise RuntimeError.new("Cannot compare #{left} and #{right}. Operands must be of type Integer or Float")
    end
  end
end

class LessThanOrEqualTo < LessThan
  def evaluate(environment)
    left = @operand_one.evaluate(environment)
    right = @operand_two.evaluate(environment)
    if (left == :int || left == :float) && (right == :int || right == :float)
      BooleanPrimitive.new(left.value <= right.value)
    else
      raise RuntimeError.new("Cannot compare #{left} and #{right}. Operands must be of type Integer or Float")
    end
  end
end

class EqualTo < Operation
  def evaluate(environment)
    left = @operand_one.evaluate(environment)
    right = @operand_two.evaluate(environment)
    if (left == :int || left == :float) && (right == :int || right == :float)
      BooleanPrimitive.new(left.value == right.value)
    else
      raise RuntimeError.new("Cannot compare #{left} and #{right}. Operands must be of type Integer or Float")
    end
  end
end

class NotEqualTo < Operation
  def evaluate(environment)
    left = @operand_one.evaluate(environment)
    right = @operand_two.evaluate(environment)
    if (left == :int || left == :float) && (right == :int || right == :float)
      BooleanPrimitive.new(left.value != right.value)
    else
      raise RuntimeError.new("Cannot compare #{left} and #{right}. Operands must be of type Integer or Float")
    end
  end
end

class And < Operation
  def evaluate(environment)
    left = @operand_one.evaluate(environment)
    right = @operand_two.evaluate(environment)
    if left == :boolean && right == :boolean
      BooleanPrimitive.new(left.value && right.value)
    else
      raise RuntimeError.new("Cannot and #{left} and #{right}.  Operands must be of type Boolean")
    end
  end
end

class Or_log < Operation
  def evaluate(environment)
    left = @operand_one.evaluate(environment)
    right = @operand_two.evaluate(environment)
    if left == :boolean && right == :boolean
      BooleanPrimitive.new(left.value || right.value)
    else
      raise RuntimeError.new("Cannot or #{left} and #{right}.  Operands must be of type Boolean")
    end
  end
end

class Not < Operation
  def evaluate(environment)
    left = @operand_one.evaluate(environment)
    if left == :boolean
      BooleanPrimitive.new(!left.value)
    else
      raise RuntimeError.new("Cannot not #{left}.  Operand must be of type Boolean")
    end
  end

  def evaluate_two(environment)
    left = @operand_one.evaluate(environment)
    right = @operand_two.evaluate(environment)
    if left == :boolean && right == :boolean
      BooleanPrimitive.new(!(left.value && right.value))
    else
      raise RuntimeError.new("Cannot not #{left} and #{right}.  Operands must be of type Boolean")
    end

  end
end

class Int_to_float < Operation
  def evaluate(environment)
    left = @operand_one.evaluate(environment)
    if left == :int
      FloatPrimitive.new(left.value)
    else
      raise RuntimeError.new("Cannot convert #{left} to float")

    end
  end
end

class Float_to_int < Operation
  def evalauate(environment)
    left = @operand_one.evaluate(environment)
    if left == :float
      IntegerPrimitive.new(left.value)
    else
      raise RuntimeError.new("Cannot convert #{left} to integer")
    end
  end
end

# class Max
#   def evaluate(environment)
#     num_list = environment
#     max_val = environment[0]
#     num_list do |item|
#
#       if item == :int || item == :float
#         max_val = item if item > max_val
#       else
#         raise RuntimeError.new("Cannot find max of list as #{item.}")
#     end
#
#     end
# end
