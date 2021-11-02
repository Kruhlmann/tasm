
require "tasm/operations/operation"

class CloneOperation < Operation
  def execute(stack, instruction_ptr)
    a = stack.pop()
    stack.append(a)
    stack.append(a)
    return instruction_ptr + 1
  end

  def asm_instruction(operation_index)
    <<~EOS
      pop rax
      push rax
      push rax
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
