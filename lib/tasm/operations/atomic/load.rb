require "tasm/operations/operation"

class LoadOperation < Operation
  def execute(stack, instruction_ptr)
  end

  def asm_instruction(operation_index, _)
    <<~EOS
      pop rax
      xor rbx, rbx
      mov bl, [rax]
      push rbx
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
