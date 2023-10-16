class Operation
    def initialize(operand1, operand2)
      @operand1, @operand2 = operand1, operand2
    end
  
    def evaluate(environment)
      raise "Not Implemented"
    end
  
    def to_s
      raise "Not Implemented"
    end
end
  
  class Add < Operation
    def evaluate(environment)
      IntegerPrimitive.new(@operand1.evaluate(environment).value + @operand2.evaluate(environment).value)
    end
  
    def to_s
      "#{@operand1.to_s} + #{@operand2.to_s}"
    end
  end
  
class Subtract < Operation
    def evaluate(environment)
        IntegerPrimitive.new(@operand1.evaluate(environment).value - @operand2.evaluate(environment).value)
    end
    def to_s
        "#{@operand1.to_s} - #{@operand2.to_s}"
    end
end

class Divide < Operation
    def evaluate(environment)
        IntegerPrimitive.new(@operand1.evaluate(environment).value / @operand2.evaluate(environment).value)
    end
    def to_s
        "#{@operand1.to_s} / #{@operand2.to_s}"
    end
end

class Multiply < Operation
    def evaluate(environment)
      if @operand1 == :float || @operand2 == :float
        FloatPrimitive.new(@operand1.evaluate(environment).value * @operand2.evaluate(environment).value)
      else
        IntegerPrimitive.new(@operand1.evaluate(environment).value * @operand2.evaluate(environment).value)
      end
    end
end

class Equals < Operation
  def evaluate(environment)

  end
end

class Not < Operation
  def evaluate(environment)

  end
end

  