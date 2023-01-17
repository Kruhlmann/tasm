require 'tasm/operations/operation'

class Rev4Operation < Operation
  def execute(stack, instruction_ptr)
    a = stack.pop
    b = stack.pop
    stack.append(a)
    stack.append(b)
    instruction_ptr + 1
  end

  def asm_instruction(_operation_index, _)
    <<~EOS
      pop r8
      pop r9
      pop r10
      pop r11
      push r8
      push r9
      push r10
      push r11
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
