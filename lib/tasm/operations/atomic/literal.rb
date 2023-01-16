require 'tasm/operations/operation'

class LiteralOperation < ArgOperation
  def execute(stack, instruction_ptr); end

  def asm_instruction(_operation_index, _)
    <<~EOS
    EOS
  end

  def nodejs_instruction(_operation_index)
    <<~EOS
    EOS
  end

  def lua_instruction(_operation_index)
    <<~EOS
    EOS
  end
end
