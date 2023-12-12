# frozen_string_literal: true

class Interpreter
  attr_accessor :input, :index, :tokMap, :tok_to_tok

  def lex(input)
    @input = input
    @index = 0
    @tok_map = []
    @tok_to_tokok = ""
    while @index < @input.length
      if has('(')
      end
    end
  end
  def has(token)
    @index < @input.length && @input[@index] == token
  end
  def has_letter
    @index < @input.length && 'a' <= @input[@index] && @input[@index] <= 'z'
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
    @tok_map.push({:type => token, :value => @tok_to_tok})
    @tok_to_tok = ''
  end
  def to_s
    "#{@tok_map}"
  end
end
