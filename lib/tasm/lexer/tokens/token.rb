require "tasm/error/lexer/unknown_symbol"

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
