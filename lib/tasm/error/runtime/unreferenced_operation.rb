class UnreferencedOperationError < RuntimeError
  def initialize(operation)
    super("unreferenced operation: '#{operation}'")
  end
end
