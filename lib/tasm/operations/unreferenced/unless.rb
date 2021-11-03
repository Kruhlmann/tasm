require "tasm/operations/unreferenced"
require "tasm/operations/atomic/unless"

class UnreferencedUnlessOperation < UnreferencedOperation
  def reference_to(reference_index)
    UnlessOperation.new(reference_index)
  end
end
