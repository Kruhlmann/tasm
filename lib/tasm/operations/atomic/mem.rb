require "tasm/operations/operation"

class MemOperation < Operation
  def execute(stack, instruction_ptr)
  end

  def asm_instruction(operation_index, _)
    <<~EOS
      push mem
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
