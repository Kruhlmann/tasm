
require "tasm/lexer/tokens/token"
require "tasm/operations/atomic/push_string"

class StringToken < Token
  def operation
    PushStringOperation.new(@symbol.to_i)
  end
end
