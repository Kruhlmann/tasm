require "tasm/operations/arg_operation"

class UnlessOperation < ArgOperation
  def execute(stack, instruction_ptr)
    a = stack.pop()
    if a == 1
      return @argument
    end
    return instruction_ptr += 1
  end

  def asm_instruction(operation_index, literals)
    <<~EOS
      pop rax
      test rax, rax
      jnz addr_#{@argument}
    EOS
  end

  def nodejs_instruction(operation_index)
    <<~EOS
      a_#{operation_index} = stack.pop();
      if (a_#{operation_index} !== 1) {
    EOS
  end

  def lua_instruction(operation_index)
    <<~EOS
      local a_#{operation_index} = table.remove(stack, 1)
      if a_#{operation_index} != 1 then
    EOS
  end
end
