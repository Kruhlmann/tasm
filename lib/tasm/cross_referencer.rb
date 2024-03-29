require 'tasm/error/runtime/cross_reference/reference_stack_empty'
require 'tasm/error/runtime/unexpected_symbol'
require 'tasm/operations/unreferenced'
require 'tasm/operations/atomic/call'

class CrossReferencer
  def cross_reference_instructions(instructions)
    reference_stack = []
    instructions.each_with_index do |operation, operation_index|
      if operation.is_a? UnreferencedIfOperation
        reference_stack.append(operation_index)
      elsif operation.is_a? UnreferencedUnlessOperation
        reference_stack.append(operation_index)
      elsif operation.is_a? UnreferencedSubOperation
        reference_stack.append(operation_index)
      elsif operation.is_a? WhileOperation
        reference_stack.append(operation_index)
      elsif operation.is_a? LiteralOperation
        prev_reference = reference_stack.pop
        if prev_reference.nil?
          instructions[operation_index] = CallOperation.new(operation.read_argument)
        elsif instructions[prev_reference].is_a? UnreferencedSubOperation
          instructions[prev_reference] = SubOperation.new(operation.read_argument)
        else
          instructions[operation_index] = CallOperation.new(operation.read_argument)
          reference_stack.push prev_reference
        end
      elsif operation.is_a? UnreferencedElseOperation
        prev_reference = reference_stack.pop
        raise UnexpectedSymbolError, 'else' unless instructions[prev_reference].is_a? UnreferencedOperation

        instructions[prev_reference] = IfOperation.new(operation_index + 1)
        instructions[operation_index] = UnreferencedElseOperation.new
        reference_stack.append(operation_index)
      elsif operation.is_a? EndIfOperation
        prev_reference = reference_stack.pop
        raise ReferenceStackEmpty if prev_reference.nil?
        raise UnexpectedSymbolError, 'endif' unless instructions[prev_reference].is_a? UnreferencedOperation

        instructions[prev_reference] = instructions[prev_reference].reference_to(operation_index)
      elsif operation.is_a? UnreferencedDoOperation
        prev_reference = reference_stack.pop
        raise ReferenceStackEmpty if prev_reference.nil?
        raise UnexpectedSymbolError, 'do' unless instructions[prev_reference].is_a? WhileOperation

        instructions[operation_index] = instructions[operation_index].reference_to(prev_reference)
        reference_stack.push(operation_index)
      elsif operation.is_a? UnreferencedEndWhileOperation
        prev_reference = reference_stack.pop
        raise ReferenceStackEmpty if prev_reference.nil?
        raise UnexpectedSymbolError, 'wend' unless instructions[prev_reference].is_a? DoOperation

        instructions[operation_index] =
          instructions[operation_index].reference_to(instructions[prev_reference].read_argument)
        instructions[prev_reference] = instructions[prev_reference].reference_to(operation_index + 1)
      end
    end
    raise ReferenceStackEmpty unless reference_stack.length.zero?

    instructions
  end
end
