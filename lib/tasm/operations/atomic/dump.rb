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

  def nodejs_instruction(operation_index)
    <<~EOS
      const a_#{operation_index} = stack.pop();
      console.log(a_#{operation_index});
    EOS
  end

  def lua_instruction(operation_index)
    <<~EOS
      local a_#{operation_index} = table.remove(stack, 1)
      print(a_#{operation_index});
    EOS
  end
end