require 'tasm/operations/operation'

class NowOperation < Operation
  def execute(stack, instruction_ptr); end

  def asm_instruction(_operation_index, _)
    <<~EOS
      mov rax, 201
      xor rdi, rdi
      syscall
      push rax
    EOS
  end

  def nodejs_instruction(_operation_index)
    <<~EOS
    EOS
  end

  def lua_instruction(_operation_index)
    <<~EOS
    EOS
  end
end
