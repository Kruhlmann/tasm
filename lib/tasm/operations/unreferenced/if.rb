require "tasm/operations/unreferenced"
require "tasm/operations/atomic/if"

class UnreferencedIfOperation < UnreferencedOperation
  def reference_to(reference_index)
    IfOperation.new(reference_index)
  end
end
