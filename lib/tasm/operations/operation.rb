class Operation
  def execute
    raise 'Not implemented'
  end

  def execute(_stack, _instruction_ptr)
    raise "'execute' not implemented"
  end

  def asm_instruction(_operation_index, _literals = [])
    raise "'asm_instruction' Not implemented"
  end

  def asm_strings(strings)
    strings
  end

  def nodejs_instruction(_operation_index)
    raise "'nodejs_instruction' Not implemented"
  end

  def to_s
    "#{self.class.name}<>"
  end
end
