require "tasm/operations/operation"

class EqualityOperation < Operation
  def execute(stack, instruction_ptr)
    a = stack.pop
    b = stack.pop
    stack.append(a == b ? 1 : 0)
    instruction_ptr += 1
    return instruction_ptr
  end

  def asm_instruction(operation_index)
    <<~EOS
      mov rcx, 0
      mov rdx, 1
      pop rax
      pop rbx
      cmp rax, rbx
      cmove rcx, rdx
      push rcx
    EOS
  end
end
