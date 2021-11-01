require "tasm/operations/operation"

class AddOperation < Operation
  def execute(stack, instruction_ptr)
    a = stack.pop
    b = stack.pop
    stack.append(b + a)
    instruction_ptr += 1
    return instruction_ptr
  end

  def asm_instruction(operation_index)
    <<~EOS
      pop rbx
      pop rax
      add rax, rbx
      push rax
    EOS
  end

  def nodejs_instruction(operation_index)
    <<~EOS
      const b_#{operation_index} = stack.pop();
      const a_#{operation_index} = stack.pop();
      stack.push(b_#{operation_index} + a_#{operation_index});
    EOS
  end

  def lua_instruction(operation_index)
    <<~EOS
      local b_#{operation_index} = table.remove(stack, 1)
      local a_#{operation_index} = table.remove(stack, 1)
      table.insert(stack, a_#{operation_index} + b_#{operation_index})
    EOS
  end
end
