require "tasm/operations/unreferenced"
require "tasm/operations/atomic/else"

class UnreferencedElseOperation < UnreferencedOperation
  def reference_to(reference_index)
    return ElseOperation.new(reference_index)
  end
end
