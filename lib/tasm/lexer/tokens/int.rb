require "tasm/lexer/tokens/token"
require "tasm/operations/atomic/push"

class IntToken < Token
  def operation
    PushOperation.new(@symbol.to_i)
  end
end
