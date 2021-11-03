require "tasm/error/runtime/cross_reference/reference_stack_empty"
require "tasm/error/runtime/unexpected_symbol"
require "tasm/operations/unreferenced"

class CrossReferencer
  def cross_reference_instructions(instructions)
    reference_stack = []
    instructions.each_with_index do |operation, operation_index|
      if operation.is_a? UnreferencedIfOperation
        reference_stack.append(operation_index)
      elsif operation.is_a? UnreferencedUnlessOperation
        reference_stack.append(operation_index)
      elsif operation.is_a? WhileOperation
        reference_stack.append(operation_index)
      elsif operation.is_a? UnreferencedElseOperation
        prev_reference = reference_stack.pop
        raise UnexpectedSymbolError.new("else") unless instructions[prev_reference].is_a? UnreferencedOperation

        instructions[prev_reference] = IfOperation.new(operation_index + 1)
        instructions[operation_index] = UnreferencedElseOperation.new
        reference_stack.append(operation_index)
      elsif operation.is_a? EndIfOperation
        prev_reference = reference_stack.pop
        raise ReferenceStackEmpty if prev_reference.nil?
        raise UnexpectedSymbolError.new("end") unless instructions[prev_reference].is_a? UnreferencedOperation

        instructions[prev_reference] = instructions[prev_reference].reference_to(operation_index)
      elsif operation.is_a? UnreferencedDoOperation
        prev_reference = reference_stack.pop
        raise ReferenceStackEmpty if prev_reference.nil?
        raise UnexpectedSymbolError.new("do") unless instructions[prev_reference].is_a? WhileOperation
        instructions[operation_index] = instructions[operation_index].reference_to(prev_reference)
        reference_stack.push(operation_index)
      elsif operation.is_a? UnreferencedEndWhileOperation
        prev_reference = reference_stack.pop
        raise ReferenceStackEmpty if prev_reference.nil?
        raise UnexpectedSymbolError.new("wend") unless instructions[prev_reference].is_a? DoOperation

        instructions[operation_index] = instructions[operation_index].reference_to(instructions[prev_reference].read_argument)
        instructions[prev_reference] = instructions[prev_reference].reference_to(operation_index + 1)
      end
    end
    raise ReferenceStackEmpty unless reference_stack.length.zero?

    instructions
  end
end
