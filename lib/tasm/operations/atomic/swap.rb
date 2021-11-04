require "tasm/operations/operation"

class SwapOperation < Operation
  def execute(stack, instruction_ptr)
    a = stack.pop()
    b = stack.pop()
    stack.append(a)
    stack.append(b)
    return instruction_ptr + 1
  end

  def asm_instruction(operation_index, _)
    <<~EOS
      pop rax
      pop rbx
      push rax
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
