require "tasm/operations/unreferenced"
require "tasm/operations/atomic/while"

class UnreferencedWhileOperation < UnreferencedOperation
  def reference_to(reference_index)
    WhileOperation.new(reference_index)
  end
end
