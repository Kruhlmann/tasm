require "tasm/operations/operation"

class EndWhileOperation < Operation
  def execute(stack, instruction_ptr)
  end

  def asm_instruction(operation_index)
    <<~EOS
      addr_#{operation_index}:
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
