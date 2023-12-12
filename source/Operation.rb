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
    if left.tag == :float || right.tag == :float
      FloatPrimitive.new(left.value + right.value)
    elsif left.tag == :int && right.tag == :int
      IntegerPrimitive.new(left.value + right.value)
    else
      raise RuntimeError.new("Cannot add #{left} and #{right}.  Operands must be of type Integer or Float")
    end
  end

  def to_s
    "(#{@operand_one} + #{@operand_two})"
  end

  class Subtraction < Operation
    def evaluate(environment)
      left = @operand_one.evaluate(environment)
      right = @operand_two.evaluate(environment)
      if left.tag == :float || right.tag == :float
        FloatPrimitive.new(left.value - right.value)
      elsif left.tag == :int && right.tag == :int
        IntegerPrimitive.new(left.value - right.value)
      else
        raise RuntimeError.new("Cannot subtract #{left} and #{right}.  Operands must be of type Integer or Float")
      end
    end

    def to_s
      "(#{@operand_one} - #{@operand_two})"
    end
  end

  class Divide < Operation
    def evaluate(environment)
      left = @operand_one.evaluate(environment)
      right = @operand_two.evaluate(environment)
      quot = left.value / right.value
      puts left
      puts right
      if left.tag == 0.0 || right.tag == 0.0
        raise RuntimeError.new("Cannot divide by 0")
      end
      if left.tag == :float || right.tag == :float
        FloatPrimitive.new(left.value.fdiv(right.value))
      elsif left.tag == :int && right.tag == :int
        if quot == 0
          FloatPrimitive.new(left.value.fdiv(right.value))
        else
          IntegerPrimitive.new(left.value / right.value)
        end
      else
        raise RuntimeError.new("Cannot divide #{left} and #{right}.  Operands must be of type Integer or Float")
      end
    end

    def to_s
      "(#{@operand_one} / #{@operand_two})"
    end
  end

  class Multiply < Operation
    def evaluate(environment)
      left = @operand_one.evaluate(environment)
      right = @operand_two.evaluate(environment)
      if left.tag == :float || right.tag == :float
        FloatPrimitive.new(left.value * right.value)
      elsif left.tag == :int && right.tag == :int
        IntegerPrimitive.new(left.value * right.value)
      else
        raise RuntimeError.new("Cannot multiply #{left} and #{left}.  Operands must be of type Integer or Float")
      end
    end

    def to_s
      "(#{@operand_one} * #{@operand_two})"
    end
  end

  class Modulus < Operation
    def evaluate(environment)
      left = @operand_one.evaluate(environment)
      right = @operand_two.evaluate(environment)
      if left.tag == :float || right.tag == :float
        FloatPrimitive.new(left.value % right.value)

      elsif left.tag == :int && right.tag == :int
        IntegerPrimitive.new(left.value % right.value)
      else
        raise RuntimeError.new("Cannot mod #{left} and #{right}.  Operands must be of type Integer or Float")
      end
    end

    def to_s
      "(#{@operand_one} % #{@operand_two})"
    end
  end

  class Exponent < Operation
    def evaluate(environment)
      left = @operand_one.evaluate(environment)
      right = @operand_two.evaluate(environment)
      if left.tag == :float || right.tag == :float
        FloatPrimitive.new(left.value ** right.value)
      elsif left.tag == :int && right.tag == :int
        IntegerPrimitive.new(left.value ** right.value)
      else
        raise RuntimeError.new("Cannot exponentiate #{left} and #{right}.  Operands must be of type Integer or Float")
      end
    end

    def to_s
      "(#{@operand_one} ^ #{@operand_two})"
    end
  end

  class BitwiseAnd < Operation
    def evaluate(environment)
      left = @operand_one.evaluate(environment)
      right = @operand_two.evaluate(environment)
      if left.tag == :int && right.tag == :int
        IntegerPrimitive.new(left.value & right.value)
      else
        raise RuntimeError.new("Cannot bitwise and #{left} and #{right}.  Both operands must be of type Integer")
      end
    end

    def to_s
      "(#{@operand_one} & #{@operand_two})"
    end
  end

  class BitwiseOr < Operation
    def evaluate(environment)
      left = @operand_one.evaluate(environment)
      right = @operand_two.evaluate(environment)
      if left.tag == :int && right.tag == :int
        IntegerPrimitive.new(left.value | right.value)
      else
        raise runtime_error("Cannot bitwise or #{left} and #{right}.  Both operands must be of type Integer")
      end
    end

    def to_s
      "#{@operand_one} | #{@operand_two}"
    end
  end

  class BitwiseXor < Operation
    def evaluate(environment)
      left = @operand_one.evaluate(environment)
      right = @operand_two.evaluate(environment)
      if left.tag == :int && right.tag == :int
        IntegerPrimitive.new(left.value ^ right.value)
      else
        raise RuntimeError.new("Cannot bitwise xor #{left} and #{right}.  Both operands must be of type Integer")
      end
    end

    def to_s
      "#{@operand_one} ^ #{@operand_two}"
    end
  end

  class BitwiseLeftShift < Operation
    def evaluate(environment)
      left = @operand_one.evaluate(environment)
      right = @operand_two.evaluate(environment)
      if left.tag == :int && right.tag == :int
        IntegerPrimitive.new(left.value << right.value)
      else
        raise RuntimeError.new("Cannot bitwise left shift #{left} and #{right}.  Both operands must be of type Integer")
      end
    end

    def to_s
      "#{@operand_one} << #{@operand_two}"
    end
  end

  class BitwiseRightShift < Operation
    def evaluate(environment)
      left = @operand_one.evaluate(environment)
      right = @operand_two.evaluate(environment)
      if left.tag == :int && right.tag == :int
        IntegerPrimitive.new(left.value >> right.value)
      else
        raise RuntimeError.new("Cannot bitwise right shift #{left} and #{right}.  Both operands must be of type Integer")
      end
    end

    def to_s
      "#{@operand_one} >> #{@operand_two}"
    end
  end

  class LessThan < Operation
    def evaluate(environment)
      left = @operand_one.evaluate(environment)
      right = @operand_two.evaluate(environment)
      if (left.tag == :int || left.tag == :float) && (right.tag == :int || right.tag == :float)
        BooleanPrimitive.new(left.value < right.value)
      else
        raise RuntimeError.new("Cannot compare #{left} and #{right}.  Operands must be of type Integer or Float")
      end
    end

    def to_s
      "#{@operand_one} < #{@operand_two}"
    end
  end

  class GreaterThan < Operation
    def evaluate(environment)
      left = @operand_one.evaluate(environment)
      right = @operand_two.evaluate(environment)
      if (left.tag == :int || left.tag == :float) && (right.tag == :int || right.tag == :float)
        BooleanPrimitive.new(left.value > right.value)
      else
        raise RuntimeError.new("Cannot compare #{left} and #{right}.  Operands must be of type Integer or Float")
      end
    end

    def to_s
      "#{@operand_one} > #{@operand_two}"
    end
  end

  class GreaterThanOrEqualTo < GreaterThan
    def evaluate(environment)
      left = @operand_one.evaluate(environment)
      right = @operand_two.evaluate(environment)
      if (left.tag == :int || left.tag == :float) && (right.tag == :int || right.tag == :float)
        BooleanPrimitive.new(left.value >= right.value)
      else
        raise RuntimeError.new("Cannot compare #{left} and #{right}. Operands must be of type Integer or Float")
      end
    end

    def to_s
      "#{@operand_one} >= #{@operand_two}"
    end
  end

  class LessThanOrEqualTo < LessThan
    def evaluate(environment)
      left = @operand_one.evaluate(environment)
      right = @operand_two.evaluate(environment)
      if (left.tag == :int || left.tag == :float) && (right.tag == :int || right.tag == :float)
        BooleanPrimitive.new(left.value <= right.value)
      else
        raise RuntimeError.new("Cannot compare #{left} and #{right}. Operands must be of type Integer or Float")
      end
    end

    def to_s
      "#{@operand_one} <= #{@operand_two}"
    end
  end

  class EqualTo < Operation
    def evaluate(environment)
      left = @operand_one.evaluate(environment)
      right = @operand_two.evaluate(environment)
      if (left.tag == :int || left.tag == :float) && (right.tag == :int || right.tag == :float)
        BooleanPrimitive.new(left.value == right.value)
      else
        raise RuntimeError.new("Cannot compare #{left} and #{right}. Operands must be of type Integer or Float")
      end
    end

    def to_s
      "#{@operand_one} == #{@operand_two}"
    end
  end

  class NotEqualTo < Operation
    def evaluate(environment)
      left = @operand_one.evaluate(environment)
      right = @operand_two.evaluate(environment)
      if (left.tag == :int || left.tag == :float) && (right.tag == :int || right.tag == :float)
        BooleanPrimitive.new(left.value != right.value)
      else
        raise RuntimeError.new("Cannot compare #{left} and #{right}. Operands must be of type Integer or Float")
      end
    end

    def to_s
      "#{@operand_one}!= #{@operand_two}"
    end
  end

  class And < Operation
    def evaluate(environment)
      left = @operand_one.evaluate(environment)
      right = @operand_two.evaluate(environment)
      if left.tag == :boolean && right.tag == :boolean
        BooleanPrimitive.new(left.value && right.value)
      else
        raise RuntimeError.new("Cannot and #{left} and #{right}.  Operands must be of type Boolean")
      end
    end

    def to_s
      "#{@operand_one} && #{@operand_two}"
    end
  end

  class Or_log < Operation
    def evaluate(environment)
      left = @operand_one.evaluate(environment)
      right = @operand_two.evaluate(environment)
      if left.tag == :boolean && right.tag == :boolean
        BooleanPrimitive.new(left.value || right.value)
      else
        raise RuntimeError.new("Cannot or #{left} and #{right}.  Operands must be of type Boolean")
      end
    end

    def to_s
      "#{@operand_one} || #{@operand_two}"
    end
  end

  class Not < Operation
    def evaluate(environment)
      left = @operand_one.evaluate(environment)
      if left.tag == :boolean
        BooleanPrimitive.new(!left.value)
      else
        raise RuntimeError.new("Cannot not #{left}.  Operand must be of type Boolean")
      end
    end

    def evaluate_two(environment)
      left = @operand_one.evaluate(environment)
      right = @operand_two.evaluate(environment)
      if left.tag == :boolean && right.tag == :boolean
        BooleanPrimitive.new(!(left.value && right.value))
      else
        raise RuntimeError.new("Cannot not #{left} and #{right}.  Operands must be of type Boolean")
      end

    end

    def to_s
      "! #{@operand_one}"
    end

    def to_s_two
      "! (#{@operand_one} && #{@operand_two})"
    end

  end

  class Int_to_float < Operation
    def evaluate(environment)
      left = @operand_one.evaluate(environment)
      if left.tag == :int || left.tag == :float
        FloatPrimitive.new(left.value)
      else
        raise RuntimeError.new("Cannot convert #{left} to float")
      end
    end

    def to_s
      "#{@operand_one} to float"
    end
  end

  class Float_to_int < Operation
    def evalauate(environment)
      left = @operand_one.evaluate(environment)
      if left.tag == :float
        IntegerPrimitive.new(left.value)
      else
        raise RuntimeError.new("Cannot convert #{left} to integer")
      end
    end

    def to_s
      "#{@operand_one} to integer"
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
