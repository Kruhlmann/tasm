require "tasm/error/lexer/unknown_symbol"
require "tasm/lexer/lookup_table"
require "tasm/operations/atomic/write"

class Token
  def initialize(symbol, context, line, column)
    @symbol = symbol
    @context = context
    @line = line
    @column = column
  end

  def length
    @symbol.to_s.length
  end

  def operation
    raise UnknownSymbolError.new(@symbol, @context, @line, @column)
  end
end

class BuiltinToken < Token
  def operation
    begin
      LexerOperationLookupTable.lookup(@symbol).new
    rescue
      raise UnknownSymbolError.new(@symbol, @context, @line, @column)
    end
  end
end

class IntToken < Token
  def operation
    PushOperation.new(@symbol.to_i)
  end
end

class Tokenizer
  def self.tokenize_symbol(symbol, context, line, column)
    token_constructor = BuiltinToken
    if symbol.to_i.to_s == symbol
      token_constructor = IntToken
    end
    return token_constructor.new(symbol, context, line, column)
  end
end

class Lexer
  def operation_from_symbol(symbol, context, line_number, current_column)
    if !lookup_result.nil?
        return lookup_result.new
    elsif symbol.to_i.to_s == symbol
      return PushOperation.new(symbol.to_i)
    end
    raise UnknownSymbolError.new(symbol, context, line_number + 1, current_column)
  end

  def lex_line_into_program(line, line_number, context, program)
    symbols = line.split
    current_column = 0

    symbols.each do |symbol|
      token = Tokenizer.tokenize_symbol(symbol, context, line_number + 1, current_column + 1)
      program.append(token.operation)
      current_column += token.length + 1
    end
  end

  def lex_lines_into_program(program, lines, context)
    lines.each_with_index do |line, line_number|
      lex_line_into_program(line, line_number, context, program)
    end
    program
  end

  def lex(source, context = "anonymous")
    program = []
    lines = source.split('\n')
    lex_lines_into_program(program, lines, context)
  end
end
