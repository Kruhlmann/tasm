require "tasm/operations/operation"

class Syscall1Operation < Operation
  def execute(stack, instruction_ptr)
    return instruction_ptr + 1
  end

  def asm_instruction(operation_index, _)
    <<~EOS
      pop rax
      pop rdi
      syscall
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
