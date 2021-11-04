require "tasm/operations/operation"

class SubtractOperation < Operation
  def execute(stack, instruction_ptr)
    a = stack.pop
    b = stack.pop
    stack.append(b - a)
    return instruction_ptr += 1
  end

  def asm_instruction(operation_index, _)
    <<~EOS
      pop rbx
      pop rax
      sub rax, rbx
      push rax
    EOS
  end

  def nodejs_instruction(operation_index)
    <<~EOS
      b_#{operation_index} = stack.pop();
      a_#{operation_index} = stack.pop();
      stack.push(b_#{operation_index} - a_#{operation_index});
    EOS
  end

  def lua_instruction(operation_index)
    <<~EOS
      local b_#{operation_index} = table.remove(stack, 1)
      local a_#{operation_index} = table.remove(stack, 1)
      table.insert(stack, b_#{operation_index} - a_#{operation_index})
    EOS
  end
end
