require "tasm/operations/operation"

class Clone2Operation < Operation
  def execute(stack, instruction_ptr)
    b = stack.pop()
    a = stack.pop()
    stack.append(a)
    stack.append(b)
    stack.append(a)
    stack.append(b)
    return instruction_ptr + 1
  end

  def asm_instruction(operation_index, _)
    <<~EOS
      pop rbx
      pop rax
      push rax
      push rbx
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
