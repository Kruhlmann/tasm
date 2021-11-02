require "tasm/operations/operation"

class DoOperation < Operation
  def execute(stack, instruction_ptr)
  end

  def asm_instruction(operation_index)
    <<~EOS
    EOS
  end

  def nodejs_instruction(operation_index)
    <<~EOS
    EOS
  end

  def lua_instruction(operation_index)
    <<~EOS
    EOS
  end
end
