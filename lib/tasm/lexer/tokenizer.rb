require "tasm/lexer/tokens/builtin"
require "tasm/lexer/tokens/int"

class Tokenizer
  def self.tokenize_symbol(symbol, context, line, column)
    token_constructor = BuiltinToken
    if symbol.to_i.to_s == symbol
      token_constructor = IntToken
    end
    return token_constructor.new(symbol, context, line, column)
  end
end

