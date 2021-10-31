class UnexpectedSymbolError < RuntimeError
  def initialize(symbol)
    super("unexpected symbol #{symbol}")
  end
end
