# frozen_string_literal: true
require_relative './CellValue.rb'
require_relative './Environment.rb'
require_relative './Grid.rb'
require_relative './Operation.rb'
require_relative './Primitive.rb'

class Interpreter
  attr_accessor :input, :index, :tokMap, :tok_to_tok

  def has(token)
    @index < @input.length && @input[@index] == token
  end

  def has_letter
    @index < @input.length && 'a' <= @input[@index] && @input[@index] <= 'z'
  end

  def has_digit
    @index < @input.length && (@input[@index].match?(/\A-?\d+\Z/))
  end

  def capture
    if @tok_to_tok == nil
      @tok_to_tok = @input[@index]
    else
      @tok_to_tok = @tok_to_tok + @input[@index]
    end
    @index += 1
  end

  def skip_tok
    @index += 1
    @tok_to_tok = ""
  end

  def emit_token(token)
    @tok_map.push({ :type => token, :value => @tok_to_tok })
    @tok_to_tok = ''
  end

  def to_s
    "#{@tok_map}"
  end

  def lexy(input)
    @input
    @input = input
    @index = 0
    @tok_map = []
    @tok_to_tok = ""
    while @index < @input.length
      if has('(')
        capture
        emit_token(:left_paren)
      elsif has(')')
        capture
        emit_token(:right_paren)
      elsif has('[')
        capture
        emit_token(:left_square_bracket)
        if has(',')
          capture
          emit_token(:coordinate_seperator)
          if has(']')
            capture
            emit_token(:right_square_bracket)
          end
        end
      elsif has('-')
        capture
        emit_token(:minus)
      elsif has('+')
        capture
        emit_token(:plus)
      elsif has('/')
        capture
        emit_token(:slash)
      elsif has('%')
        capture
        emit_token(:modulo)
      elsif has('!')
        capture
        if has('=')
          capture
          emit_token(:not_equal)
        else
          emit_token(:NOT)
        end
      elsif has(',')
        capture
        emit_token(:coordinate_seperator)
      elsif has('=')
        capture
        if has('=')
          capture
          emit_token(:logic_equal)
        else
          emit_token(:equal)
        end
      elsif has('*')
        capture
        if has('*')
          capture
          emit_token(:exponential)
        else
          emit_token(:multiply)
        end
      elsif has('<')
        capture
        if has('=')
          capture
          emit_token(:less_equal)
        elsif has('<')
          capture
          emit_token(:left_shift)
        else
          emit_token(:less)
        end
      elsif has('>')
        capture
        if has('=')
          capture
          emit_token(:greater_equal)
        elsif has('>')
          capture
          emit_token(:right_shift)
        else
          emit_token(:greater)
        end
      elsif has('|')
        capture
        if has('|')
          capture
          emit_token(:logical_or)
        else
          emit_token(:bitwise_or)
        end
      elsif has('&')
        capture
        if has('&')
          capture
          emit_token(:logical_and)
        else
          emit_token(:bitwise_and)
        end
      elsif has('~')
        capture
        emit_token(:bitwise_not)
      elsif has('^')
        capture
        emit_token(:bitwise_xor)
      elsif has('T') || has('F')
        capture
        emit_token(:boolean)
      elsif has_digit
        while has_digit
          capture
        end
        if has('.')
          capture
          while has_digit
            capture
          end
          emit_token(:float)
        else
          emit_token(:integer)
        end
      else
        skip_tok
      end
    end
    @tok_map
  end
end

class Parser
  def initialize(input)
    @input = input
    @index = 0
  end

  def has(type_flag)
    @index < @input.length && @input[@index] == type_flag
  end

  def parse
    left = logicaor
    continue
    if has(:right_paren)
      continue
      left = logicalor
    end
    left
  end

  def logicalor
    left = logicaland
    continue
    while has(:logical_or)
      if has(:logical_or)
        continue
        right = logicaland
        left = Or_log.new(left, right)
      end
    end
    left
  end

  def logicaland
    left = bitwiseor
    while has(:logical_and)
      if has(:logical_and)
        continue
        right = bitwiseor
        left = And.new(left, right)
      end
    end
    left
  end

  def bitwiseor
    left = bitwisexor
    while has(:bitwise_or)
      if has(:bitwise_or)
        continue
        right = bitwisexor
        left = BitwiseOr.new(left, right)
      end
    end
    left
  end

  def bitwisexor
    left = bitwiseand
    while has(:bitwise_xor)
      if has(:bitwise_xor)
        continue
        right = bitwiseand
        left = BitwiseXor.new(left, right)
      end
    end
    left
  end

  def bitwiseand
    left = equality
    while has(:bitwise_and)
      if has(:bitwise_and)
        continue
        right = equality
        left = BitwiseAnd.new(left, right)
      end
    end
    left
  end

  def equality
    left = relational
    while has(:equal) || has(:not_equal)
      if has(:equal)
        continue
        right = relational
        left = EqualTo.new(left, right)
      elsif has(:not_equal)
        continue
        right = relational
        left = NotEqualTo.new(left, right)
      end
    end
    left
  end

  def relational
    left = bit_shift

    while has(:greater) || has(:greater_equal) || has(:less) || has(:less_equal)
      if has(:greater)
        continue
        right = bit_shift
        left = GreaterThan.new(left, right)
      elsif has(:greater_equal)
        continue
        right = bit_shift
        left = GreaterThanOrEqualTo.new(left, right)
      elsif has(:less)
        continue
        right = bit_shift
        left = LessThan.new(left, right)
      elsif has(:less_equal)
        continue
        right = bit_shift
        left = LessThanOrEqualTo.new(left, right)
      end
    end
    left
  end

  def bit_shift
    left = additive
    while has(:left_shift) || has(:right_shift)
      if has(:right_shift)
        continue
        right = additive
        left = BitwiseRightShift.new(left, right)
      elsif has(:left_shift)
        continue
        right = additive
        left = BitwiseLeftShift.new(left, right)
      end
    end
    left
  end

  def additive
    left = multiplicative
    while has(:plus) || has(:minus)
      if has(:plus)
        continue
        right = multiplicative
        left = Addition.new(left, right)
      elsif has(:minus)
        continue
        right = multiplicative
        left = Subtraction.new(left, right)
      end
    end
  end

  def multiplicative
    left = exponential
    while has(:multiply) || has(:slash) || has(:modulo)
      if has(:multiply)
        continue
        right = exponential
        left = Multiply.new(left, right)
      elsif has(:slash)
        contineue
        right = exponential
        left = Divide.new(left, right)
      elsif has(:modulo)
        continue
        right = exponential
        left = Modulus.new(left, right)
      end
    end
    left
  end

  def exponential
    left = negate
    while has(:exponential)
      if has(:exponential)
        continue
        right = negate
        left = Exponent.new(left, right)
      end
    end
    left
  end

  def negate
    if has(:NOT)
      continue
      right = atom
      left = Not.new(right)
    else
      left = atom
    end
    left
  end

  def atom
    while has(:IntegerPrimitive) || has(:FloatPrimitive) || has(:left_paren) || has(:left_square_bracket)
      tok = @input[@index][:token]
      if has(:IntegerPrimitive)
        continue
        IntegerPrimitive.new(tok)
      elsif has(:Float)
        continue
        FloatPrimitive.new(tok)
      elsif has(:boolean)
        continue
        if tok == "t"
          BooleanPrimitive.new(true)
        elsif tok == "f"
          BooleanPrimitive.new(false)
        end
      elsif has(:left_paren)
        if has_ahead(:left_paren)
          continue
          return parse
        else
          raise Exception.new("Unmatched left parenthesis")
        end
      end
    end
  end

  def has_ahead(type_flag)
    k = @index
    for k in @input
      if @input[:type] == type_flag
        return true
      end
      return false
    end
  end

  def continue
    @index += 1
  end

end
