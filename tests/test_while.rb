require_relative './case'

class WhileTestCase < TestCase
  def self.source
    <<~EOS
      10 while clone 0 > do
          clone put
          --
      wend
      11 put
    EOS
  end

  def self.expected
    <<~EOS
      10
      9
      8
      7
      6
      5
      4
      3
      2
      1
      11
    EOS
  end
end

WhileTestCase.execute
