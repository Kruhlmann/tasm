require "tasm/operations/operation"

class AddOperation < Operation
  def execute(stack, instruction_ptr)
    a = stack.pop
    b = stack.pop
    stack.append(b + a)
    instruction_ptr += 1
    return instruction_ptr
  end

  def asm_instruction(operation_index)
    <<~EOS
      pop rbx
      pop rax
      add rax, rbx
      push rax
    EOS
  end

  def nodejs_instruction
    <<~EOS
      b = stack.pop();
      a = stack.pop();
      stack.push(b + a);
    EOS
  end
end
