require 'tasm/operations/operation'

class AddOperation < Operation
  def execute(_stack, instruction_ptr)
    instruction_ptr + 1
  end

  def asm_instruction(_operation_index, _)
    <<~EOS
      pop rbx
      pop rax
      add rax, rbx
      push rax
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
