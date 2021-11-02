require "tasm/operations/operation"

class WhileOperation < Operation
  def execute(stack, instruction_ptr)
    return instruction_ptr + 1
  end

  def asm_instruction(operation_index)
    <<~EOS
      addr_#{operation_index}:
    EOS
  end

  def nodejs_instruction(operation_index)
    <<~EOS
      while (stack.pop() === 1) {
    EOS
  end

  def lua_instruction(operation_index)
    <<~EOS
      while table.remove(stack, 1)
    EOS
  end
end
