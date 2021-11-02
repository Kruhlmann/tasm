class AssertionError < RuntimeError
  def initialize(message, expected, actual)
    small_tab = "        "
    tab = "          "
    expected_formatted = expected.split("\n").join("\n#{tab}")
    actual_formatted = actual.split("\n").join("\n#{tab}")
    super("#{message}\n#{small_tab}expected:\n#{tab}#{expected_formatted}\n#{small_tab}actual:\n#{tab}#{actual_formatted}")
  end
end
