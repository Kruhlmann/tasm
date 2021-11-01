require "tasm/operations/operation"

class DumpOperation < Operation
  def execute(stack, instruction_ptr)
    puts stack.pop
    instruction_ptr += 1
    return instruction_ptr
  end

  def asm_instruction(operation_index)
    <<~EOS
      pop rdi
      call dump
    EOS
  end

  def nodejs_instruction
    <<~EOS
      a = stack.pop();
      console.log(a);
    EOS
  end
end
