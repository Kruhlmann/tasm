require "tasm/operations/arg_operation"

class ElseOperation < ArgOperation
  def execute(stack, instruction_ptr)
    return instruction_ptr + 1
  end

  def asm_instruction(operation_index, _)
    <<~EOS
      jmp addr_#{@argument}
      addr_#{operation_index + 1}:
    EOS
  end

  def nodejs_instruction(operation_index)
    <<~EOS
      } else {
    EOS
  end

  def lua_instruction(operation_index)
    <<~EOS
      else
    EOS
  end
end
