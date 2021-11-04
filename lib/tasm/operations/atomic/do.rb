require "tasm/operations/operation"

class DoOperation < ArgOperation
  def execute(stack, instruction_ptr)
    a = stack.pop()
    if a == 0
      return @argument
    end
    return instruction_ptr + 1
  end

  def asm_instruction(operation_index, _)
    <<~EOS
      pop rax
      test rax, rax
      jz addr_#{@argument}
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

  def reference_to(reference_index)
    DoOperation.new(reference_index)
  end
end
