require "tasm/operations/arg_operation"

class WhileOperation < ArgOperation
  def execute(stack, instruction_ptr)
  end

  def asm_instruction(operation_index)
    <<~EOS
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
