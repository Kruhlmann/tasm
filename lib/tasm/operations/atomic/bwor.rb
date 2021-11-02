require "tasm/operations/operation"

class BitwiseOrOperation < Operation
  def execute(stack, instruction_ptr)
    b = stack.pop()
    a = stack.pop()
    stack.append(a | b)
    return instruction_ptr + 1
  end

  def asm_instruction(operation_index)
    <<~EOS
      pop rbx
      pop rax
      or rbx, rax
      push rbx
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
