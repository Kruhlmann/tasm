require_relative "./case"

class BitwiseTestCase < TestCase
  def self.source
    <<~EOS
      1 3 << put
      32 3 >> put
      1 2 | put
      1 2 & put
    EOS
  end

  def self.expected
    <<~EOS
      8
      4
      3
      0
    EOS
  end
end

BitwiseTestCase.execute
