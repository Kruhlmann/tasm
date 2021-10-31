require "tasm/error/lexer/lexer"

class UnknownSymbolError < LexerError
  def initialize(symbol, context, line, column)
    @symbol = symbol
    @context = context
    @line = line
    @column = column
    super("Unknown symbol '#{symbol}' in #{context}:#{line}:#{column}")
  end

  def to_s
    "#{@context}:#{@line}:#{@column}: unknown symbol '#{@symbol}'"
  end
end
