require "tasm/operations/arg_operation"

class IfOperation < ArgOperation
  def execute(stack, instruction_ptr)
    a = stack.pop()
    if a != 1
      instruction_ptr = @argument
    else
      instruction_ptr += 1
    end
    return instruction_ptr
  end

  def asm_instruction(operation_index)
    <<~EOS
        pop rax
        test rax, rax
        jz addr_#{@argument}
    EOS
  end
end
