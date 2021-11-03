require "tasm/error/lexer/unknown_symbol"
require "tasm/lexer/tokens/token"
require "tasm/lexer/lookup_table"

class BuiltinToken < Token
  def operation
    begin
      LexerOperationLookupTable.lookup(@symbol).new
    rescue
      raise UnknownSymbolError.new(@symbol, @context, @line, @column)
    end
  end
end
