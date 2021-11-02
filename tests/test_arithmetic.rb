require_relative "./case"

class ArithmeticTestCase < TestCase
  def self.source
    <<~EOS
    1 2 + put
    10 8 - put
    10 10 = put
    10 12 = put
    10 12 > put
    10 12 < put
    EOS
  end

  def self.expected
    <<~EOS
    3
    2
    1
    0
    0
    1
    EOS
  end
end
ArithmeticTestCase.execute
