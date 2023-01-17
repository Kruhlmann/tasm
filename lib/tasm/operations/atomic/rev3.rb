require 'tasm/operations/operation'

class Rev3Operation < Operation
  def execute(stack, instruction_ptr)
    a = stack.pop
    b = stack.pop
    stack.append(a)
    stack.append(b)
    instruction_ptr + 1
  end

  def asm_instruction(_operation_index, _)
    <<~EOS
      pop rax
      pop rbx
      pop rcx
      push rax
      push rbx
      push rcx
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
