require "tasm/operations/operation"

class DecrementOperation < Operation
  def execute(stack, instruction_ptr)
    const a = stack.pop()
    stack.push(a - 1);
    return instruction_ptr += 1
  end

  def asm_instruction(operation_index, _)
    <<~EOS
      push 1
      pop rbx
      pop rax
      sub rax, rbx
      push rax
    EOS
  end

  def nodejs_instruction(operation_index)
    <<~EOS
      const a_#{operation_index} = stack.pop();
      stack.push(a#{operation_index} - 1);
    EOS
  end

  def lua_instruction(operation_index)
    <<~EOS
      local a_#{operation_index} = table.remove(stack, 1)
      table.insert(stack, a_#{operation_index} - 1);
    EOS
  end
end
