class And < Operation
  def evaluate(environment)
    BooleanPrimitive.new(@operand1.evaluate(environment).value && @operand2.evaluate(environment).value)
  end

  def to_s
    "#{@operand1.to_s} AND #{@operand2.to_s}"
  end
end
