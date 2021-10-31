require "tasm/error/runtime/unreferenced_operation"
require "tasm/operations/operation"

class UnreferencedOperation < Operation
  def execute(stack, instruction_ptr)
    raise UnreferencedOperationError.new("#{self.class.name}")
  end

  def asm_instruction(operation_index)
    raise UnreferencedOperationError.new("#{self.class.name}")
  end

  def reference_to(reference_index)
    return UnreferencedOperation
  end
end
