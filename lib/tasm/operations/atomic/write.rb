require "tasm/operations/operation"

class WriteOperation < Operation
  def execute(stack, instruction_ptr)
  end

  def asm_instruction(operation_index, literals)
    <<~EOS
      pop rbx
      pop rax
      mov [rax], bl
    EOS
  end

  def nodejs_instruction(operation_index)
    <<~EOS
    EOS
  end

  def lua_instruction(operation_index)
    <<~EOS
    EOS
  end
end
