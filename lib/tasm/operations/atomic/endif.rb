require "tasm/operations/operation"

class EndIfOperation < Operation
  def execute(stack, instruction_ptr)
  end

  def asm_instruction(operation_index)
    <<~EOS
      addr_#{operation_index}:
    EOS
  end
end
