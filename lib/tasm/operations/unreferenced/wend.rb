require "tasm/operations/unreferenced"
require "tasm/operations/atomic/wend"

class UnreferencedEndWhileOperation < UnreferencedOperation
  def reference_to(reference_index)
    EndWhileOperation.new(reference_index)
  end
end
