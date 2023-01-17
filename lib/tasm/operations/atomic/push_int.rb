require 'tasm/operations/arg_operation'

class PushIntOperation < ArgOperation
  def execute(stack, instruction_ptr)
    stack.append(@argument)
    instruction_ptr += 1
  end

  def asm_instruction(_operation_index, _)
    <<~EOS
      push #{@argument}
    EOS
  end

  def nodejs_instruction(_operation_index)
    <<~EOS
      stack.push(#{@argument});
    EOS
  end

  def lua_instruction(_operation_index)
    <<~EOS
      table.insert(stack, #{@argument});
    EOS
  end
end
