require "tasm/operations/unreferenced"
require "tasm/operations/atomic/do"

class UnreferencedDoOperation < UnreferencedOperation
  def reference_to(reference_index)
    DoOperation.new(reference_index)
  end
end
