require 'tasm/operations/operation'

class SubOperation < ArgOperation
  def execute(_stack, instruction_ptr)
    instruction_ptr + 1
  end

  def asm_instruction(_operation_index, _)
    <<~EOS
      usr_#{@argument}:
      push rbp
      mov rbp, rsp
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
