class Primitive
  attr_accessor :value, :tag

  def initialize(value)
    @value = value
  end

  def evaluate(environment)
    self
  end

  def to_s
    @value.to_s
  end
end

class IntegerPrimitive < Primitive
  def initialize(value)
    super(value)
    @tag = :int
  end
end

# def evaluate(environment)
#   self
# end

class FloatPrimitive < Primitive
  def initialize(value)
    super(value)
    @tag = :float
  end

  # def evaluate(environment)
  #   self
  # end
end

class BooleanPrimitive < Primitive
  def initialize(value)
    super(value)
    @tag = :bool
  end

  # def evaluate(environment)
  #   self
  # end
end

class StringPrimitive < Primitive
  def initialize(value)
    super(value)
    @tag = :string
  end

  # def evaluate(environment)
  #   self
  # end
end
end