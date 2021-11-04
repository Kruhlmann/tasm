class Operation
  def execute
    raise "Not implemented"
  end

  def execute(stack, instruction_ptr)
    raise "'execute' not implemented"
  end

  def asm_instruction(operation_index, literals = [])
    raise "'asm_instruction' Not implemented"
  end

  def asm_strings(strings)
    strings
  end

  def nodejs_instruction(operation_index)
    raise "'nodejs_instruction' Not implemented"
  end
end
