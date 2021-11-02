require "tasm/operations/operation"

class DropOperation < Operation
  def execute(stack, instruction_ptr)
    stack.pop()
  end

  def asm_instruction(operation_index)
    <<~EOS
      pop rax
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
