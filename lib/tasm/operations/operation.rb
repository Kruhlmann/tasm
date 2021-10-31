class Operation
  def execute
    raise "Not implemented"
  end

  def as_asm(operation_index)
    "#{comment}\n#{asm_instruction(operation_index)}"
  end

  def execute(stack, instruction_ptr)
    raise "'execute' not implemented"
  end

  def asm_instruction(operation_index)
    raise "'asm_instruction' Not implemented"
  end

  def comment
    ";; #{self.class.name}"
  end
end
