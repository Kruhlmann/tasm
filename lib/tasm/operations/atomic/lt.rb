require "tasm/operations/operation"

class LessThanOperation < Operation
  def execute(stack, instruction_ptr)
    b = stack.pop
    a = stack.pop
    stack.append(a < b ? 1 : 0)
    return instruction_ptr += 1
  end

  def asm_instruction(operation_index, _)
    <<~EOS
      mov rcx, 0
      mov rdx, 1
      pop rbx
      pop rax
      cmp rax, rbx
      cmovl rcx, rdx
      push rcx
    EOS
  end

  def nodejs_instruction(operation_index)
    <<~EOS
      const b_#{operation_index} = stack.pop();
      const a_#{operation_index} = stack.pop();
      stack.push(a_#{operation_index} < b_#{operation_index} ? 1 : 0);
    EOS
  end

  def lua_instruction(operation_index)
    <<~EOS
      local b_#{operation_index} = table.remove(stack, 1)
      local a_#{operation_index} = table.remove(stack, 1)
      if a_#{operation_index} < b_#{operation_index} then table.insert(stack, 1) else table.insert(stack, 0) end
    EOS
  end
end
