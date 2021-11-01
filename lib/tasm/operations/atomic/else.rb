require "tasm/operations/arg_operation"

class ElseOperation < ArgOperation
  def execute(stack, instruction_ptr)
  end

  def asm_instruction(operation_index)
    <<~EOS
      jmp addr_#{@argument}
      addr_#{operation_index + 1}:
    EOS
  end

  def nodejs_instruction
    <<~EOS
      } else {
    EOS
  end
end
