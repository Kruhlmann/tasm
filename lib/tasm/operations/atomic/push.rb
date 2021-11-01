require "tasm/operations/arg_operation"

class PushOperation < ArgOperation
  def execute(stack, instruction_ptr)
    stack.append(@argument)
    instruction_ptr += 1
    return instruction_ptr
  end

  def asm_instruction(operation_index)
    <<~EOS
      push #{@argument}
    EOS
  end

  def nodejs_instruction(operation_index)
    <<~EOS
      stack.push(#{@argument});
    EOS
  end

  def lua_instruction(operation_index)
    <<~EOS
      table.insert(stack, #{@argument});
    EOS
  end
end
