require "tasm/operations/arg_operation"

class PushStringOperation < ArgOperation
  def execute(stack, instruction_ptr)
  end

  def asm_instruction(operation_index, literals)
    literals.push(@argument)
    <<~EOS
      mov rax, #{@argument.length}
      push rax
      push lit_#{literals.length - 1}
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
