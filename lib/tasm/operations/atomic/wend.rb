require "tasm/operations/arg_operation"

class EndWhileOperation < ArgOperation
  def execute(stack, instruction_ptr)
    return @argument
  end

  def asm_instruction(operation_index, literals)
    <<~EOS
      jmp addr_#{@argument}
      addr_#{operation_index + 1}:
    EOS
  end

  def nodejs_instruction(operation_index)
    <<~EOS
      }
    EOS
  end

  def lua_instruction(operation_index)
    <<~EOS
      end
    EOS
  end
end
