class Primitive
    attr_reader :value, :tag
    def to_s
      @value.to_s
    end
end
  
class IntegerPrimitive < Primitive
    def initialize(value)
        @value = value
        @tag = :integer
    end
end
class FloatPrimitive < Primitive
    def initialize(value)
        @value = value
        @tag = :float
    end
end
class BooleanPrimitive < Primitive
    def initialize(value)
        @value = value
        @tag = :bool
    end
end
class StringPrimitive < Primitive
    def initialize(value)
        @value = value
        @tag = :string
    end
end
  