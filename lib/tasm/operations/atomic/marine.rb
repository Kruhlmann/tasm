require 'tasm/operations/operation'

class MarineOperation < Operation
  def execute(_stack, instruction_ptr)
    instruction_ptr + 1
  end

  def asm_instruction(_operation_index, _)
    <<~EOS
      mov rsp, rbp
      pop rbp
      ret
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
