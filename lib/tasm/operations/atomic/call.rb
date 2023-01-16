require 'tasm/operations/arg_operation'

class CallOperation < ArgOperation
  def execute(_stack, instruction_ptr)
    instruction_ptr + 1
  end

  def asm_instruction(_operation_index, _)
    <<~EOS
      call usr_#{@argument}
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
